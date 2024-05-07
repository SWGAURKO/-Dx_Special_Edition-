import { useState } from "react";
import useData from "../../hooks/useData";
import useRouter from "../../hooks/useRouter";
import { JobProps, JobCarSpawnerProps } from "../../types/JobTypes";
import { BsArrowLeft, BsFillCarFrontFill } from "react-icons/bs";
import { AiOutlineEdit, AiOutlinePlusCircle } from "react-icons/ai";
import classNames from "classnames";
import AddCarSpawnerForm from "../../components/JobCars/AddCarSpawnerForm";
import EditCarSpawnerForm from "../../components/JobCars/EditCarSpawnerForm";

const JobCars = () => {
  const { Jobs, addJobCarSpawner, updateJobCarSpawner } = useData();
  const { editedJobIdentity, setRouter } = useRouter();
  const [editCarSpawner, setEditCarSpawner] = useState<
    JobCarSpawnerProps | undefined
  >(undefined);
  const [Job, setJob] = useState<JobProps | undefined>(
    Jobs.find((job) => job.identity === editedJobIdentity)
  );

  if (!Job) {
    setRouter("jobs");
    return;
  }

  const onAddCarSpawner = async (
    event: React.FormEvent,
    newCarSpawner: JobCarSpawnerProps
  ) => {
    event.preventDefault();
    const createdCarSpawner = await addJobCarSpawner(
      Job.identity,
      newCarSpawner
    );
    if (typeof createdCarSpawner !== "boolean") {
      setJob((prevJob) => {
        if (!prevJob) return;
        return {
          ...prevJob,
          carSpawners: [...(prevJob.carSpawners || []), createdCarSpawner],
        };
      });
    }
  };

  const onUpdateCarSpawner = async (
    event: React.FormEvent,
    updateCarSpawner: JobCarSpawnerProps
  ) => {
    event.preventDefault();
    const _updateCarSpawner = await updateJobCarSpawner(
      Job.identity,
      updateCarSpawner
    );
    if (typeof _updateCarSpawner !== "boolean") {
      setJob((prevJob) => {
        if (!prevJob) return;
        const updateCarSpawners = prevJob.carSpawners.map((spawner) => {
          if (spawner.id === _updateCarSpawner.id) {
            return {
              ..._updateCarSpawner,
            };
          } else {
            return spawner;
          }
        });
        return { ...prevJob, carSpawners: updateCarSpawners };
      });
    }
  };

  const handleEditCarSpawnerClick = (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    const { spawnerid } = event.currentTarget.dataset;
    const spawner = Job.carSpawners.find(
      (spawner) => spawner.id === Number(spawnerid)
    );
    setEditCarSpawner(spawner);
  };

  return (
    <div>
      <div className="p-2 max-sm:text-sm font-medium text-white lg:text-lg border-b border-primary-400 flex gap-2 items-center">
        <button onClick={() => setRouter("jobs")} className="mr-1">
          <BsArrowLeft />
        </button>
        <BsFillCarFrontFill />
        <span>Job Car Spawners [{Job.identity}] </span>
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
            {Job.carSpawners &&
              Job.carSpawners.map((item) => (
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
                      onClick={handleEditCarSpawnerClick}
                      data-spawnerid={item.id}
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
      {!editCarSpawner && (
        <div>
          <div className="px-2 pt-2 font-medium text-white lg:text-lg flex gap-2 items-center">
            <div>
              <AiOutlinePlusCircle />
            </div>
            <span>Add Job Car Spawner</span>
          </div>
          <div className="p-2">
            <AddCarSpawnerForm Job={Job} onAddCarSpawner={onAddCarSpawner} />
          </div>
        </div>
      )}
      {editCarSpawner && (
        <div>
          <div className="px-2 pt-2 font-medium text-orange-100 lg:text-lg flex gap-2 items-center">
            <button
              onClick={() => setEditCarSpawner(undefined)}
              className="mr-1"
            >
              <BsArrowLeft />
            </button>
            <div>
              <BsFillCarFrontFill />
            </div>
            <span>Edit Job Car Spawner [{editCarSpawner.name}]</span>
          </div>
          <div className="p-2">
            <EditCarSpawnerForm
              Job={Job}
              editCarSpawner={editCarSpawner}
              onUpdateCarSpawner={onUpdateCarSpawner}
            />
          </div>
        </div>
      )}
    </div>
  );
};

export default JobCars;
