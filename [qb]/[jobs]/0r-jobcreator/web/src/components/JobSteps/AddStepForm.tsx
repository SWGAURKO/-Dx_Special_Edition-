import { ChangeEvent, useMemo, useState } from "react";
import { JobInputProps, JobProps, JobStepProps } from "../../types/JobTypes";
import { AddStepInputs } from "../JobSteps/inputs";
import { AiOutlinePlusCircle } from "react-icons/ai";
import { IoMdRemoveCircleOutline } from "react-icons/io";
import { MdShareLocation } from "react-icons/md";
import { useUtils } from "../../hooks/useUtils";
import { vector4Type } from "../../types/useUtilsTypes";

const AddStepForm = ({
  Job,
  onAddJobStep,
}: {
  Job: JobProps | undefined;
  onAddJobStep: (
    event: React.FormEvent<HTMLFormElement>,
    newStep: JobStepProps
  ) => void;
}) => {
  const inputs = useMemo(() => AddStepInputs(Job ?? undefined), [Job]);
  const [newStep, setNewStep] = useState<JobStepProps>({} as JobStepProps);
  const { getPlayerCoords } = useUtils();

  const [addNewCoord, setAddNewCoord] = useState<vector4Type>({
    x: 0.0,
    y: 0.0,
    z: 0.0,
  });

  const handleInputChange = (
    e: ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ): void => {
    const { name, value } = e.target;
    setNewStep((prevStep) => {
      const updatedStep = { ...prevStep };
      const nameParts = name.split(".");
      let currentSection = updatedStep;
      for (let i = 0; i < nameParts.length; i++) {
        const part = nameParts[i];
        if (i === nameParts.length - 1) {
          currentSection[part] = value;
        } else {
          if (i == 0 && Array.isArray(currentSection[part])) {
            currentSection[part] = {};
          }
          currentSection = currentSection[part] ??= {};
        }
      }
      return updatedStep;
    });
  };

  const handleAddNewStepCoord = (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    setNewStep((prevStep) => ({
      ...prevStep,
      coords: [...(prevStep.coords || []), addNewCoord],
    }));
  };

  const handleNewStepCoordChange = (
    e: ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    const { name, value } = e.target;
    setAddNewCoord((prevValues) => ({
      ...prevValues,
      [name]: value,
    }));
  };

  const handleGetVector4 = async () => {
    const playerCoords = await getPlayerCoords();
    setAddNewCoord(playerCoords);
  };

  const handleRemoveStepCoord = (indexToRemove: number) => {
    setNewStep((prevStep) => {
      const updatedCoords = prevStep.coords.filter(
        (_, index) => index !== indexToRemove
      );
      return {
        ...prevStep,
        coords: updatedCoords,
      };
    });
  };

  function renderInputField(input: JobInputProps) {
    const uniqueId = `new_step_${input.uniqueName.replace(".", "_")}`;
    const pathParts = input.uniqueName.split(".");
    let currentStep: any = newStep;

    for (const part of pathParts) {
      if (part in currentStep) {
        currentStep = currentStep[part];
      } else {
        currentStep = undefined;
        break;
      }
    }
    const inputValue = currentStep ?? "";

    if (input.showWhen && !input.showWhen(newStep)) {
      return null;
    }

    return (
      <div key={uniqueId} className={input.className}>
        <label htmlFor={uniqueId} className="block  text-primary-100">
          {input.label}
        </label>
        {input.type === "select" ? (
          <select
            className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
            id={uniqueId}
            name={input.uniqueName}
            value={inputValue}
            onChange={handleInputChange}
            required={input.required}
            {...input.attributes}
          >
            {input.options?.map((option) => (
              <option key={option.value} value={option.value}>
                {option.label}
              </option>
            ))}
          </select>
        ) : input.type === "coords" ? (
          <div className="grid grid-cols-4 w-full">
            <input
              className="disabled:bg-primary-700 bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block p-2.5 text-center text-primary-100"
              type="number"
              step={0.01}
              id={uniqueId + "_x"}
              name={input.uniqueName + ".x"}
              placeholder="X"
              value={inputValue.x}
              onChange={handleInputChange}
              required={true}
            />
            <input
              className="disabled:bg-primary-700 bg-primary-900 border border-l-0 border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block p-2.5 text-center text-primary-100"
              type="number"
              step={0.01}
              id={uniqueId + "_y"}
              name={input.uniqueName + ".y"}
              placeholder="Y"
              value={inputValue.y}
              onChange={handleInputChange}
              required={true}
            />
            <input
              className="disabled:bg-primary-700 bg-primary-900 border border-l-0 border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block p-2.5 text-center text-primary-100"
              type="number"
              step={0.01}
              id={uniqueId + "_z"}
              name={input.uniqueName + ".z"}
              placeholder="Z"
              value={inputValue.z}
              onChange={handleInputChange}
              required={true}
            />
            <input
              className="disabled:bg-primary-700 bg-primary-900 border border-l-0 border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block p-2.5 text-center text-primary-100"
              type="number"
              step={0.01}
              id={uniqueId + "_h"}
              name={input.uniqueName + ".h"}
              placeholder="W"
              value={inputValue.h}
              onChange={handleInputChange}
              required={true}
            />
          </div>
        ) : (
          <input
            className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
            type={input.type}
            id={uniqueId}
            name={input.uniqueName}
            placeholder={input.label}
            value={inputValue}
            onChange={handleInputChange}
            required={input.required}
            {...input.attributes}
          />
        )}
        <div className="ml-1">
          <span className="text-gray-400 text-xs">* {input.description}</span>
          {input.hintLink && (
            <div>
              <span className="text-gray-400 md:text-xs underline">
                {input.hintLink}
              </span>
            </div>
          )}
        </div>
      </div>
    );
  }

  return (
    <>
      <form onSubmit={(event) => onAddJobStep(event, newStep)}>
        <div className="grid md:grid-cols-3 gap-4 mb-2">
          <div>
            <label
              htmlFor="new_step_coords"
              className="block text-primary-100 float-left"
            >
              <span>Zones Coords</span>
            </label>
            <div className="relative">
              <button
                type="button"
                onClick={handleGetVector4}
                className="text-yellow-500 hover:text-yellow-300 absolute right-0"
                title="Get your current position & heading (vector4)."
              >
                <MdShareLocation size={18} />
              </button>
              <button
                onClick={handleAddNewStepCoord}
                type="button"
                className="text-yellow-500 hover:text-yellow-300 absolute right-6"
                title="Add new coords for that step."
              >
                <AiOutlinePlusCircle size={18} />
              </button>
            </div>
            <div className="grid grid-cols-3 w-full">
              <input
                className="disabled:bg-primary-700 bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block p-2.5 text-center text-primary-100"
                type="number"
                step={0.01}
                name="x"
                placeholder="X"
                required={false}
                onChange={handleNewStepCoordChange}
                value={addNewCoord.x}
              />
              <input
                className="disabled:bg-primary-700 bg-primary-900 border border-l-0 border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block p-2.5 text-center text-primary-100"
                type="number"
                step={0.01}
                name="y"
                placeholder="Y"
                required={false}
                onChange={handleNewStepCoordChange}
                value={addNewCoord.y}
              />
              <input
                className="disabled:bg-primary-700 bg-primary-900 border border-l-0 border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block p-2.5 text-center text-primary-100"
                type="number"
                step={0.01}
                name="z"
                placeholder="Z"
                required={false}
                onChange={handleNewStepCoordChange}
                value={addNewCoord.z}
              />
            </div>
            <div className="ml-1">
              <span className="text-gray-400 text-xs">
                * At least one coordinate must be added
              </span>
            </div>
            {newStep.coords?.length > 0 && (
              <div
                key="newStep.coords.map"
                className="mt-2 rounded-b bg-primary-900 border border-primary-300 block p-1 text-primary-100 space-y-1"
              >
                {newStep.coords?.map((coords, index) => (
                  <div
                    key={index}
                    className="bg-primary-700 p-1 flex justify-between items-center w-full rounded"
                  >
                    <div>
                      ({coords.x}) , ({coords.y}) , ({coords.z})
                    </div>
                    <button
                      type="button"
                      onClick={() => handleRemoveStepCoord(index)}
                    >
                      <IoMdRemoveCircleOutline size={18} />
                    </button>
                  </div>
                ))}
              </div>
            )}
          </div>
          {inputs.map((input: JobInputProps) => renderInputField(input))}
        </div>
        <div className="w-full mt-auto">
          <button
            type="submit"
            className="ml-auto flex items-center gap-1 justify-between bg-primary-600 text-primary-100 p-2 px-6 rounded hover:bg-primary-500 transition duration-300 shadow"
          >
            <div>Add</div>
          </button>
        </div>
      </form>
    </>
  );
};

export default AddStepForm;
