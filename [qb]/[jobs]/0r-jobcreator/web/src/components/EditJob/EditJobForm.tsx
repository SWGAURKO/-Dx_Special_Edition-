import { ChangeEvent, Dispatch, SetStateAction, useMemo } from "react";
import { MdShareLocation } from "react-icons/md";
import { JobInputProps, JobProps } from "../../types/JobTypes";
import { useUtils } from "../../hooks/useUtils";
import { EditJobInputs } from "../../components/EditJob/inputs";

const EditJobForm = ({
  Job,
  setJob,
  onUpdateJob,
}: {
  Job: JobProps;
  setJob: Dispatch<SetStateAction<JobProps>>;
  onUpdateJob: (event: React.FormEvent<HTMLFormElement>) => void;
}) => {
  const inputs = useMemo(() => EditJobInputs(Job ?? undefined), [Job]);
  const { getPlayerCoords } = useUtils();

  const handleInputChange = (
    e: ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ): void => {
    const { name, value } = e.target;
    setJob((prevJob) => {
      const updatedJob = { ...prevJob };
      const nameParts = name.split(".");
      let currentSection = updatedJob;
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
      return updatedJob;
    });
  };

  const handleGetVector4 = async () => {
    const playerCoords = await getPlayerCoords();
    setJob((prevJob) => {
      return {
        ...prevJob,
        start_ped: {
          ...prevJob.start_ped,
          coords: playerCoords,
        },
      };
    });
  };

  function renderInputField(input: JobInputProps) {
    const uniqueId = `edit_job_${input.uniqueName.replace(".", "_")}`;
    const pathParts = input.uniqueName.split(".");
    let currentObject: any = Job;
    for (const part of pathParts) {
      if (part in currentObject) {
        currentObject = currentObject[part];
      } else {
        currentObject = undefined;
        break;
      }
    }
    const inputValue = currentObject ?? "";
    if (input.showWhen && !input.showWhen(Job ?? ({} as JobProps))) {
      return null;
    }

    return (
      <div key={uniqueId} className={input.className}>
        <label
          htmlFor={uniqueId}
          className="block  text-primary-100 float-left"
        >
          {input.label}
        </label>
        {input.type == "coords" && input.attributes?.useGetCoord && (
          <div className="relative">
            <button
              type="button"
              onClick={handleGetVector4}
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
    <form onSubmit={(event) => onUpdateJob(event)}>
      <div className="grid gap-4 mb-2 md:grid-cols-3">
        {inputs.map((input: JobInputProps) => renderInputField(input))}
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

export default EditJobForm;
