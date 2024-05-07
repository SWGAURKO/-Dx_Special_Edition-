import { useEffect, useState } from "react";
import {
  BsArrowLeft,
  BsDatabaseFillGear,
  BsQuestionOctagon,
  BsTrash,
} from "react-icons/bs";
import useData from "../../hooks/useData";
import useRouter from "../../hooks/useRouter";
import EditJobForm from "../../components/EditJob/EditJobForm";
import { JobProps } from "../../types/JobTypes";
import { Switch } from "@headlessui/react";
import classNames from "classnames";

const EditJob = () => {
  const {
    Jobs,
    updateJobMainSettings,
    updateJobStatusByIdentity,
    deleteJobByIdentity,
  } = useData();
  const { editedJobIdentity, setRouter } = useRouter();
  const [Job, setJob] = useState<JobProps>(
    Jobs.find((job) => job.identity === editedJobIdentity) ?? ({} as JobProps)
  );
  const [isConfirming, setIsConfirming] = useState(false);

  useEffect(() => {
    if (isConfirming) {
      const timeoutId = setTimeout(() => {
        setIsConfirming(false);
      }, 5000);
      return () => {
        clearTimeout(timeoutId);
      };
    }
  }, [isConfirming]);

  const onUpdateJob = async (event: React.FormEvent) => {
    event.preventDefault();
    const updatedJob = await updateJobMainSettings(Job);
    if (typeof updatedJob !== "boolean") {
      setJob(updatedJob);
    }
  };

  const handleSetJobStatus = async (checked: boolean) => {
    const updatedStatus = await updateJobStatusByIdentity(
      Job.identity,
      checked
    );
    setJob((prevJob) => {
      return {
        ...prevJob,
        status: updatedStatus,
      };
    });
  };
  const handleDeleteJob = async (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    if (isConfirming) {
      const jobIdentity = Job.identity;
      const result = await deleteJobByIdentity(jobIdentity);
      if (result) {
        setRouter("jobs");
      }
      setIsConfirming(false);
    } else {
      setIsConfirming(true);
    }
  };

  return (
    <>
      <div>
        {isConfirming && (
          <div
            className="bg-red-100 border-t-4 border-red-500 rounded-b text-red-900 px-4 py-3 shadow-md"
            role="alert"
          >
            <div className="flex">
              <div className="py-1">
                <BsQuestionOctagon className="w-6 h-6 text-red-500 mr-4" />
              </div>
              <div>
                <p className="font-bold">Are you sure ?</p>
                <p className="text-sm">Press again to delete the job.</p>
              </div>
            </div>
          </div>
        )}
        <div className="p-2 max-sm:text-sm font-medium text-white lg:text-lg border-b border-primary-400 flex gap-2 items-center">
          <button
            type="button"
            onClick={() => setRouter("jobs")}
            className="mr-1"
          >
            <BsArrowLeft />
          </button>
          <BsDatabaseFillGear />
          <span>Edit Job [{Job.identity}] </span>
          <div className="ml-auto">
            <div className="flex items-center gap-2">
              <Switch
                checked={Job.status === "active"}
                onChange={handleSetJobStatus}
                className={classNames(
                  "relative inline-flex h-6 w-11 items-center rounded-full",
                  {
                    "bg-green-500": Job.status === "active",
                    "bg-red-500": Job.status !== "active",
                  }
                )}
              >
                <span className="sr-only">Job Status</span>
                <span
                  className={classNames(
                    "inline-block h-4 w-4 transform rounded-full bg-white transition",
                    {
                      "translate-x-6": Job.status === "active",
                      "translate-x-1": Job.status !== "active",
                    }
                  )}
                />
              </Switch>
              <button
                type="button"
                onClick={handleDeleteJob}
                className="ml-auto bg-primary-600 p-1 rounded text-primary-100 hover:bg-primary-500 shadow"
              >
                <BsTrash />
              </button>
            </div>
          </div>
        </div>
        <div className="p-2 border-b border-primary-600">
          <EditJobForm Job={Job} setJob={setJob} onUpdateJob={onUpdateJob} />
        </div>
      </div>
    </>
  );
};

export default EditJob;
