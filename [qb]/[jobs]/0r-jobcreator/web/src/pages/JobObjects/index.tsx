import { useEffect, useState } from "react";
import useData from "../../hooks/useData";
import useRouter from "../../hooks/useRouter";
import { JobProps, JobObjectProps } from "../../types/JobTypes";
import { BsArrowLeft, BsQuestionOctagon, BsTrash } from "react-icons/bs";
import { AiOutlineEdit, AiOutlinePlusCircle } from "react-icons/ai";
import classNames from "classnames";
import { FaRegObjectUngroup } from "react-icons/fa6";
import AddObjectForm from "../../components/JobObjects/AddObjectForm";
import EditObjectForm from "../../components/JobObjects/EditObjectForm";

const JobObjects = () => {
  const { Jobs, addJobObject, updateJobObject, deleteJobObject } = useData();
  const { editedJobIdentity, setRouter } = useRouter();
  const [editObject, setEditObject] = useState<JobObjectProps | undefined>(
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

  const onAddObject = async (
    event: React.FormEvent,
    newObject: JobObjectProps
  ) => {
    event.preventDefault();
    const createdObject = await addJobObject(Job.identity, newObject);
    if (typeof createdObject !== "boolean") {
      setJob((prevJob) => {
        if (!prevJob) return;
        return {
          ...prevJob,
          objects: [...(prevJob.objects || []), createdObject],
        };
      });
    }
  };

  const onUpdateObject = async (
    event: React.FormEvent,
    updateObject: JobObjectProps
  ) => {
    event.preventDefault();
    const _updatedObject = await updateJobObject(Job.identity, updateObject);
    if (typeof _updatedObject !== "boolean") {
      setJob((prevJob) => {
        if (!prevJob) return;
        const updateObjects = prevJob.objects.map((object) => {
          if (object.id === _updatedObject.id) {
            return {
              ..._updatedObject,
            };
          } else {
            return object;
          }
        });
        return { ...prevJob, objects: updateObjects };
      });
    }
  };

  const handleEditObjectClick = (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    const { objectid } = event.currentTarget.dataset;
    const object = Job.objects.find((object) => object.id === Number(objectid));
    setEditObject(object);
  };

  const handleDeleteJobObject = async (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    if (isConfirming) {
      const jobIdentity = Job.identity;
      const { objectid } = event.currentTarget.dataset;
      if (objectid) {
        const result = await deleteJobObject(jobIdentity, Number(objectid));
        if (result) {
          setRouter("editJob");
        }
        setIsConfirming(false);
      }
    } else {
      setIsConfirming(true);
    }
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
        <FaRegObjectUngroup />
        <span>Job Objects [{Job.identity}] </span>
      </div>
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
              <p className="text-sm">Press again to delete the object.</p>
            </div>
          </div>
        </div>
      )}
      <div className="p-2 relative overflow-x-auto no-scrollbar mb-6">
        <table className="w-full text-sm text-left text-primary-700">
          <thead className="text-xs text-primary-100 uppercase bg-primary-500">
            <tr>
              <th scope="col" className="px-6 py-3">
                Name
              </th>
              <th align="center" scope="col" className="px-6 py-3">
                Model Hash
              </th>
              <th align="center" scope="col" className="px-6 py-3">
                Action
              </th>
            </tr>
          </thead>
          <tbody>
            {Job.objects &&
              Job.objects.map((item) => (
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
                    {item.model_hash}
                  </td>
                  <td align="center" className="px-6 py-4">
                    <button
                      type="button"
                      onClick={handleEditObjectClick}
                      data-objectid={item.id}
                    >
                      <AiOutlineEdit className="text-primary-800" size={18} />
                    </button>
                    <button
                      type="button"
                      onClick={handleDeleteJobObject}
                      data-objectid={item.id}
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
      {!editObject && (
        <div>
          <div className="px-2 pt-2 font-medium text-white lg:text-lg flex gap-2 items-center">
            <div>
              <AiOutlinePlusCircle />
            </div>
            <span>Add Job Object</span>
          </div>
          <div className="p-2">
            <AddObjectForm onAddObject={onAddObject} />
          </div>
        </div>
      )}
      {editObject && (
        <div>
          <div className="px-2 pt-2 font-medium text-orange-100 lg:text-lg flex gap-2 items-center">
            <button
              type="button"
              onClick={() => setEditObject(undefined)}
              className="mr-1"
            >
              <BsArrowLeft />
            </button>
            <div>
              <FaRegObjectUngroup />
            </div>
            <span>Edit Job Object [{editObject.name}]</span>
          </div>
          <div className="p-2">
            <EditObjectForm
              editObject={editObject}
              onUpdateObject={onUpdateObject}
            />
          </div>
        </div>
      )}
    </div>
  );
};

export default JobObjects;
