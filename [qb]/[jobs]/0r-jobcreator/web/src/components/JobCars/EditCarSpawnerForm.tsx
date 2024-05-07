import { ChangeEvent, useState, useMemo } from "react";
import { MdShareLocation } from "react-icons/md";
import {
  JobCarSpawnerProps,
  JobInputProps,
  JobProps,
} from "../../types/JobTypes";
import { useUtils } from "../../hooks/useUtils";
import { AddCarSpawnerInputs } from "./inputs";
import { AiOutlinePlusCircle } from "react-icons/ai";
import { IoMdRemoveCircleOutline } from "react-icons/io";

const EditCarSpawnerForm = ({
  Job,
  editCarSpawner,
  onUpdateCarSpawner,
}: {
  Job: JobProps;
  editCarSpawner: JobCarSpawnerProps;
  onUpdateCarSpawner: (
    event: React.FormEvent<HTMLFormElement>,
    updatedCarSpawner: JobCarSpawnerProps
  ) => void;
}) => {
  const inputs = useMemo(() => AddCarSpawnerInputs(Job ?? undefined), [Job]);
  const [carSpawner, setCarSpawner] =
    useState<JobCarSpawnerProps>(editCarSpawner);
  const { getPlayerCoords } = useUtils();
  const [addNewCarModel, setAddNewCarModel] = useState<{ model: string }>(
    {} as { model: string }
  );

  const handleInputChange = (
    e: ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ): void => {
    const { name, value } = e.target;

    setCarSpawner((prevCarSpawner) => {
      const updatedCarSpawner = { ...prevCarSpawner };
      const nameParts = name.split(".");
      let currentSection = updatedCarSpawner;
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
      return updatedCarSpawner;
    });
  };

  const handleGetVector4 = async (which: string) => {
    const playerCoords = await getPlayerCoords();
    setCarSpawner((prevCarSpawner) => {
      return {
        ...prevCarSpawner,
        coords: (which == "coords" && playerCoords) || prevCarSpawner.coords,
        car_spawner_coords:
          (which == "car_spawner_coords" && playerCoords) ||
          prevCarSpawner.car_spawner_coords,
      };
    });
  };

  const handleAddNewCarModel = (event: React.MouseEvent<HTMLButtonElement>) => {
    event.preventDefault();
    const mdl = addNewCarModel.model;
    if (!mdl || mdl.length == 0 || mdl == "") {
      return;
    }
    setCarSpawner((prevCarSpawner) => ({
      ...prevCarSpawner,
      cars: [...(prevCarSpawner.cars || []), addNewCarModel],
    }));
    setAddNewCarModel({} as { model: string });
  };

  const handleNewCarModelChange = (
    e: ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    const { name, value } = e.target;
    setAddNewCarModel((prevValues) => ({
      ...prevValues,
      [name]: value.trim(),
    }));
  };

  const handleRemoveCarModel = (indexToRemove: number) => {
    setCarSpawner((prevCarSpawner) => {
      const updatedCars = prevCarSpawner.cars.filter(
        (_, index) => index !== indexToRemove
      );
      return {
        ...prevCarSpawner,
        cars: updatedCars,
      };
    });
  };

  function renderInputField(input: JobInputProps) {
    const uniqueId = `edit_carSpawner_${input.uniqueName.replace(".", "_")}`;
    const part = input.uniqueName;
    const currentCarSpawner: any = carSpawner[part];
    const inputValue = currentCarSpawner ?? "";

    return (
      <div key={uniqueId} className={input.className}>
        <label htmlFor={uniqueId} className="block text-primary-100 float-left">
          {input.label}
        </label>
        {input.type == "coords" && input.attributes?.useGetCoord && (
          <div className="relative">
            <button
              type="button"
              onClick={() => handleGetVector4(input.uniqueName)}
              className="text-yellow-500 hover:text-yellow-300 absolute right-0"
              title="Get your current position & heading (vector4)."
            >
              <MdShareLocation size={18} />
            </button>
          </div>
        )}
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
    <form onSubmit={(event) => onUpdateCarSpawner(event, carSpawner)}>
      <div className="grid gap-4 mb-2 md:grid-cols-3">
        {inputs.map((input: JobInputProps) => renderInputField(input))}
        <div>
          <label
            htmlFor="new_car_spawner_models"
            className="block text-primary-100 float-left"
          >
            <span>Car Models</span>
          </label>
          <div className="relative">
            <button
              type="button"
              onClick={handleAddNewCarModel}
              className="text-yellow-500 hover:text-yellow-300 absolute right-0"
            >
              <AiOutlinePlusCircle size={18} />
            </button>
          </div>
          <div>
            <input
              className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
              type={"text"}
              id={"new_car_spawner_models"}
              name={"model"}
              placeholder={"Car model name"}
              required={false}
              onChange={handleNewCarModelChange}
              value={addNewCarModel.model}
            />
          </div>
          <div className="ml-1">
            <span className="text-gray-400 text-xs">* Car model name</span>
          </div>
          {carSpawner.cars?.length > 0 && (
            <div
              key="newCarSpawner.cars.map"
              className="mt-2 rounded-b bg-primary-900 border border-primary-300 block p-1 text-primary-100 space-y-1"
            >
              {carSpawner.cars?.map((car, index) => (
                <div
                  key={index}
                  className="bg-primary-700 p-1 flex justify-between items-center w-full rounded"
                >
                  <div>{car.model}</div>
                  <button
                    type="button"
                    onClick={() => handleRemoveCarModel(index)}
                  >
                    <IoMdRemoveCircleOutline size={18} />
                  </button>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
      <div className="w-full mt-auto">
        <button
          type="submit"
          className="ml-auto flex items-center gap-1 justify-between bg-primary-600 text-primary-100 p-2 px-6 rounded hover:bg-primary-500 transition duration-300 shadow"
        >
          <div>Save</div>
        </button>
      </div>
    </form>
  );
};

export default EditCarSpawnerForm;
