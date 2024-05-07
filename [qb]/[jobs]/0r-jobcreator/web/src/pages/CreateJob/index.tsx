import { ChangeEvent, useState } from "react";
import { BsDatabaseFillAdd } from "react-icons/bs";
import { MdNavigateNext } from "react-icons/md";
import { CreateJobInputs } from "../../components/CreateJob/inputs";
import useData from "../../hooks/useData";
import { JobInputProps, JobProps } from "../../types/JobTypes";

const CreateJob = () => {
  const { createNewJob } = useData();

  const [CreateJobformValues, setCreateJobFormValues] = useState<JobProps>(
    {} as JobProps
  );

  const handleInputChange = (
    e: ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ): void => {
    const { name, value } = e.target;
    setCreateJobFormValues((prevJob) => {
      const updatedJob = { ...prevJob };
      const nameParts = name.split(".");

      let currentSection = updatedJob;

      for (let i = 0; i < nameParts.length; i++) {
        const part = nameParts[i];
        if (i === nameParts.length - 1) {
          currentSection[part] = value;
        } else {
          currentSection = currentSection[part] ??= {};
        }
      }
      return updatedJob;
    });
  };

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
    await createNewJob(CreateJobformValues);
  };

  function renderInputField(input: JobInputProps) {
    const uniqueId = `create_job_${input.uniqueName.replace(".", "_")}`;
    const pathParts = input.uniqueName.split(".");
    let currentJob: any = CreateJobformValues;

    for (const part of pathParts) {
      if (part in currentJob) {
        currentJob = currentJob[part];
      } else {
        currentJob = undefined;
        break;
      }
    }
    const inputValue = (currentJob as string) ?? "";

    if (
      input.showWhen &&
      !input.showWhen(CreateJobformValues ?? ({} as JobProps))
    ) {
      return null;
    }

    return (
      <div key={uniqueId}>
        <label
          htmlFor={input.uniqueName}
          className="block  text-primary-100"
        >
          {input.label}
        </label>
        {input.type === "select" ? (
          <select
            id={input.uniqueName}
            name={input.uniqueName}
            className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
            required={input.required}
            onChange={handleInputChange}
            value={inputValue}
          >
            {input.options?.map((option) => (
              <option key={option.value} value={option.value}>
                {option.label}
              </option>
            ))}
          </select>
        ) : (
          <input
            type={input.type}
            id={input.uniqueName}
            name={input.uniqueName}
            className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
            placeholder={input.label}
            required={input.required}
            onChange={handleInputChange}
            value={inputValue}
          />
        )}
        <div className="ml-1">
          <span className="text-gray-400 text-xs">* {input.description}</span>
        </div>
      </div>
    );
  }

  return (
    <div>
      <div className="p-2 text-white lg:text-lg border-b border-primary-600 flex gap-2 items-center">
        <BsDatabaseFillAdd />
        <span>Create New Job</span>
      </div>
      <div className="p-2">
        <form onSubmit={handleSubmit}>
          <div className="grid gap-6 mb-6 md:grid-cols-2">
            {CreateJobInputs.map((input: JobInputProps) =>
              renderInputField(input)
            )}
          </div>
          <div className="w-full mt-auto">
            <button
              type="submit"
              className="ml-auto flex items-center gap-1 justify-between bg-primary-600 text-primary-100 p-2 px-6 rounded hover:bg-primary-500 transition duration-300 shadow"
            >
              <div>Create</div>
              <MdNavigateNext size={18} />
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default CreateJob;
