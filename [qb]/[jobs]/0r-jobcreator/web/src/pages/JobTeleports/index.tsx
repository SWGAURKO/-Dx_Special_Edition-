import { useState } from "react";
import useData from "../../hooks/useData";
import useRouter from "../../hooks/useRouter";
import { JobProps, JobTeleportProps } from "../../types/JobTypes";
import { BsArrowLeft } from "react-icons/bs";
import { GiTeleport } from "react-icons/gi";
import { AiOutlineEdit, AiOutlinePlusCircle } from "react-icons/ai";
import AddTeleportForm from "../../components/JobTeleports/AddTeleportForm";
import classNames from "classnames";
import EditTeleportForm from "../../components/JobTeleports/EditTeleportForm";

const JobTeleports = () => {
  const { Jobs, addJobTeleport, updateJobTeleport } = useData();
  const { editedJobIdentity, setRouter } = useRouter();
  const [editTeleport, setEditTeleport] = useState<
    JobTeleportProps | undefined
  >(undefined);
  const [Job, setJob] = useState<JobProps | undefined>(
    Jobs.find((job) => job.identity === editedJobIdentity)
  );

  if (!Job) {
    setRouter("jobs");
    return;
  }

  const onAddTeleport = async (
    event: React.FormEvent,
    newTeleport: JobTeleportProps
  ) => {
    event.preventDefault();
    const createdTeleport = await addJobTeleport(Job.identity, newTeleport);
    if (typeof createdTeleport !== "boolean") {
      setJob((prevJob) => {
        if (!prevJob) return;
        return {
          ...prevJob,
          teleports: [...(prevJob.teleports || []), createdTeleport],
        };
      });
    }
  };

  const onUpdateTeleport = async (
    event: React.FormEvent,
    updateTeleport: JobTeleportProps
  ) => {
    event.preventDefault();
    const _updatedTeleport = await updateJobTeleport(
      Job.identity,
      updateTeleport
    );
    if (typeof _updatedTeleport !== "boolean") {
      setJob((prevJob) => {
        if (!prevJob) return;
        const updateTeleports = prevJob.teleports.map((teleport) => {
          if (teleport.id === _updatedTeleport.id) {
            return {
              ..._updatedTeleport,
            };
          } else {
            return teleport;
          }
        });
        return { ...prevJob, teleports: updateTeleports };
      });
    }
  };

  const handleEditTeleportClick = (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    const { teleportid } = event.currentTarget.dataset;
    const teleport = Job.teleports.find(
      (teleport) => teleport.id === Number(teleportid)
    );
    setEditTeleport(teleport);
  };

  return (
    <div>
      <div className="p-2 max-sm:text-sm font-medium text-white lg:text-lg border-b border-primary-400 flex gap-2 items-center">
        <button
          type="button"
          onClick={() => setRouter("jobs")}
          className="mr-1"
        >
          <BsArrowLeft />
        </button>
        <GiTeleport />
        <span>Job Teleports [{Job.identity}] </span>
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
                Type
              </th>
              <th align="center" scope="col" className="px-6 py-3">
                Action
              </th>
            </tr>
          </thead>
          <tbody>
            {Job.teleports &&
              Job.teleports.map((item) => (
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
                    {item.interaction_type.toUpperCase()}
                  </td>
                  <td align="center" className="px-6 py-4">
                    {item.type}
                  </td>
                  <td align="center" className="px-6 py-4">
                    <button
                      type="button"
                      onClick={handleEditTeleportClick}
                      data-teleportid={item.id}
                    >
                      <AiOutlineEdit className="text-primary-800" size={18} />
                    </button>
                  </td>
                </tr>
              ))}
          </tbody>
        </table>
      </div>
      <hr className="border-primary-400" />
      {!editTeleport && (
        <div>
          <div className="px-2 pt-2 font-medium text-white lg:text-lg flex gap-2 items-center">
            <div>
              <AiOutlinePlusCircle />
            </div>
            <span>Add Job Teleport</span>
          </div>
          <div className="p-2">
            <AddTeleportForm Job={Job} onAddTeleport={onAddTeleport} />
          </div>
        </div>
      )}
      {editTeleport && (
        <div>
          <div className="px-2 pt-2 font-medium text-orange-100 lg:text-lg flex gap-2 items-center">
            <button
              type="button"
              onClick={() => setEditTeleport(undefined)}
              className="mr-1"
            >
              <BsArrowLeft />
            </button>
            <div>
              <GiTeleport />
            </div>
            <span>Edit Job Teleport [{editTeleport.name}]</span>
          </div>
          <div className="p-2">
            <EditTeleportForm
              Job={Job}
              editTeleport={editTeleport}
              onUpdateTeleport={onUpdateTeleport}
            />
          </div>
        </div>
      )}
    </div>
  );
};

export default JobTeleports;
