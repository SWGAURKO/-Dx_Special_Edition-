import { useState, useEffect } from "react";
import useData from "../../hooks/useData";
import useRouter from "../../hooks/useRouter";
import { JobProps, JobStashProps } from "../../types/JobTypes";
import { BsArrowLeft, BsQuestionOctagon, BsTrash } from "react-icons/bs";
import { AiOutlineEdit, AiOutlinePlusCircle } from "react-icons/ai";
import classNames from "classnames";
import { LuWarehouse } from "react-icons/lu";
import AddStashForm from "../../components/JobStashes/AddStashForm";
import EditStashForm from "../../components/JobStashes/EditStashForm";

const JobStashes = () => {
  const { Jobs, addJobStash, updateJobStash, deleteJobStash } = useData();
  const { editedJobIdentity, setRouter } = useRouter();
  const [editStash, setEditStash] = useState<JobStashProps | undefined>(
    undefined
  );
  const [Job, setJob] = useState<JobProps | undefined>(
    Jobs.find((job) => job.identity === editedJobIdentity)
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

  if (!Job) {
    setRouter("jobs");
    return;
  }

  const onAddStash = async (
    event: React.FormEvent,
    newStash: JobStashProps
  ) => {
    event.preventDefault();
    const createdStash = await addJobStash(Job.identity, newStash);
    if (typeof createdStash !== "boolean") {
      setJob((prevJob) => {
        if (!prevJob) return;
        return {
          ...prevJob,
          stashes: [...(prevJob.stashes || []), createdStash],
        };
      });
    }
  };

  const onUpdateStash = async (
    event: React.FormEvent,
    updateStash: JobStashProps
  ) => {
    event.preventDefault();
    const _updateStash = await updateJobStash(Job.identity, updateStash);
    if (typeof _updateStash !== "boolean") {
      setJob((prevJob) => {
        if (!prevJob) return;
        const updateStashes = prevJob.stashes.map((stash) => {
          if (stash.id === _updateStash.id) {
            return {
              ..._updateStash,
            };
          } else {
            return stash;
          }
        });
        return { ...prevJob, stashes: updateStashes };
      });
    }
  };

  const handleDeleteJobStash = async (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    if (isConfirming) {
      const jobIdentity = Job.identity;
      const { stashid } = event.currentTarget.dataset;
      if (stashid) {
        const result = await deleteJobStash(jobIdentity, Number(stashid));
        if (result) {
          setRouter("editJob");
        }
        setIsConfirming(false);
      }
    } else {
      setIsConfirming(true);
    }
  };

  const handleEditStashClick = (event: React.MouseEvent<HTMLButtonElement>) => {
    event.preventDefault();
    const { stashid } = event.currentTarget.dataset;
    const stash = Job.stashes.find((stash) => stash.id === Number(stashid));
    setEditStash(stash);
  };

  return (
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
              <p className="text-sm">Press again to delete the stash.</p>
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
        <LuWarehouse />
        <span>Job Stashes [{Job.identity}] </span>
      </div>
      <div className="p-2 relative overflow-x-auto no-scrollbar mb-6">
        <table className="w-full text-sm text-left text-primary-700">
          <thead className="text-xs text-primary-100 uppercase bg-primary-500">
            <tr>
              <th scope="col" className="px-6 py-3">
                Name
              </th>
              <th align="center" scope="col" className="px-6 py-3">
                Interaction Type
              </th>
              <th align="center" scope="col" className="px-6 py-3">
                Action
              </th>
            </tr>
          </thead>
          <tbody>
            {Job.stashes &&
              Job.stashes.map((item) => (
                <tr
                  key={item.id}
                  className={classNames(
                    { "bg-primary-300": item.id % 2 == 0 },
                    { "bg-primary-200": item.id % 2 != 0 }
                  )}
                >
                  <th
                    scope="row"
                    className="px-6 py-3 font-medium text-primary-900 whitespace-nowrap"
                  >
                    {item.name}
                  </th>
                  <td align="center" className="px-6 py-4">
                    {item.interaction_type}
                  </td>
                  <td align="center" className="px-6 py-4">
                    <button
                      type="button"
                      onClick={handleEditStashClick}
                      data-stashid={item.id}
                    >
                      <AiOutlineEdit className="text-primary-800" size={18} />
                    </button>
                    <button
                      type="button"
                      onClick={handleDeleteJobStash}
                      data-stashid={item.id}
                      className="ml-3"
                    >
                      <BsTrash className="text-primary-800" size={18} />
                    </button>
                  </td>
                </tr>
              ))}
          </tbody>
        </table>
      </div>
      <hr className="border-primary-400" />
      {!editStash && (
        <div>
          <div className="px-2 pt-2 font-medium text-white lg:text-lg flex gap-2 items-center">
            <div>
              <AiOutlinePlusCircle />
            </div>
            <span>Add Job Stash</span>
          </div>
          <div className="p-2">
            <AddStashForm Job={Job} onAddStash={onAddStash} />
          </div>
        </div>
      )}
      {editStash && (
        <div>
          <div className="px-2 pt-2 font-medium text-orange-100 lg:text-lg flex gap-2 items-center">
            <button
              type="button"
              onClick={() => setEditStash(undefined)}
              className="mr-1"
            >
              <BsArrowLeft />
            </button>
            <div>
              <LuWarehouse />
            </div>
            <span>Edit Job Stash [{editStash.name}]</span>
          </div>
          <div className="p-2">
            <EditStashForm
              Job={Job}
              editStash={editStash}
              onUpdateStash={onUpdateStash}
            />
          </div>
        </div>
      )}
    </div>
  );
};

export default JobStashes;
