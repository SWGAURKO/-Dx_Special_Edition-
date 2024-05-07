import { useState, useEffect } from "react";
import { AiOutlineEdit, AiOutlinePlusCircle } from "react-icons/ai";
import useData from "../../hooks/useData";
import AddStepForm from "../../components/JobSteps/AddStepForm";
import { JobProps, JobStepProps } from "../../types/JobTypes";
import useRouter from "../../hooks/useRouter";
import {
  BsArrowLeft,
  BsDatabaseFill,
  BsDatabaseFillGear,
  BsQuestionOctagon,
  BsTrash,
} from "react-icons/bs";
import Pagination from "../../components/Pagination";
import { PaginationProps } from "../../types/useUtilsTypes";
import classNames from "classnames";
import EditStepForm from "../../components/JobSteps/EditStepForm";

const JobSteps = () => {
  const { Jobs, addJobStep, updateJobStep, deleteJobStep } = useData();
  const { editedJobIdentity, setRouter } = useRouter();
  const itemsPerPage = 5;
  const [currentItems, setCurrentItems] = useState<JobStepProps[]>([]);
  const [editStep, setEditStep] = useState<JobStepProps | undefined>(undefined);
  const [pageCount, setPageCount] = useState(0);
  const [itemOffset, setItemOffset] = useState(0);

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

  useEffect(() => {
    if (!Job) return;
    const endOffset = itemOffset + itemsPerPage;
    setCurrentItems(Job.steps?.slice(itemOffset, endOffset));
    setPageCount(Math.ceil((Job.steps?.length ?? 0) / itemsPerPage));
  }, [itemOffset, Job]);

  if (!Job) {
    setRouter("jobs");
    return;
  }

  const onAddJobStep = async (
    event: React.FormEvent,
    newStep: JobStepProps
  ) => {
    event.preventDefault();
    const createdStep = await addJobStep(Job.identity, newStep);
    if (typeof createdStep !== "boolean") {
      setJob((prevJob) => {
        if (!prevJob) return;
        return {
          ...prevJob,
          steps: [...(prevJob.steps || []), createdStep],
        };
      });
    }
  };

  const onUpdateJobStep = async (
    event: React.FormEvent,
    updatedStep: JobStepProps
  ) => {
    event.preventDefault();
    const _updatedStep = await updateJobStep(Job.identity, updatedStep);
    if (typeof _updatedStep !== "boolean" && _updatedStep) {
      setJob((prevJob) => {
        if (!prevJob) return;
        const updatedSteps = prevJob.steps.map((step) => {
          if (step.id === _updatedStep.id) {
            return {
              ...step,
              animation: _updatedStep.animation,
              author: _updatedStep.author,
              blip: _updatedStep.blip,
              cool_down: _updatedStep.cool_down,
              coords: _updatedStep.coords,
              give_item: _updatedStep.give_item,
              give_money: _updatedStep.give_money,
              interaction_type: _updatedStep.interaction_type,
              radius: _updatedStep.radius,
              remove_item: _updatedStep.remove_item,
              remove_money: _updatedStep.remove_money,
              required_item: _updatedStep.required_item,
              title: _updatedStep.title,
            };
          } else {
            return step;
          }
        });
        return { ...prevJob, steps: updatedSteps };
      });
    }
  };

  const handleEditStepClick = (event: React.MouseEvent<HTMLButtonElement>) => {
    event.preventDefault();
    const { stepid } = event.currentTarget.dataset;
    const step = Job.steps.find((step) => step.id === Number(stepid));
    setEditStep(step);
  };

  const handlePageClick = (event: PaginationProps) => {
    if (!Job) return;
    const newOffset = (event.selected * itemsPerPage) % Job.steps.length;
    setItemOffset(newOffset);
  };

  const handleDeleteJobStep = async (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    if (isConfirming) {
      const jobIdentity = Job.identity;
      const { stepid } = event.currentTarget.dataset;
      if (stepid) {
        const result = await deleteJobStep(jobIdentity, Number(stepid));
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
    <>
      <div className="border-b-4 border-double border-primary-600">
        <div className="p-2 text-white lg:text-lg border-b border-primary-600 flex gap-2 items-center">
          <BsDatabaseFill />
          <span>Job Steps</span>
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
                <p className="text-sm">Press again to delete the step.</p>
              </div>
            </div>
          </div>
        )}
        <div className="p-2 relative overflow-x-auto no-scrollbar mb-6">
          <table className="w-full text-sm text-left text-primary-700">
            <thead className="text-xs text-primary-100 uppercase bg-primary-500">
              <tr>
                <th scope="col" className="px-6 py-3">
                  Title
                </th>
                <th align="center" scope="col" className="px-6 py-3">
                  Interaction Type
                </th>
                <th align="center" scope="col" className="px-6 py-3">
                  Cool Down
                </th>
                <th align="center" scope="col" className="px-6 py-3">
                  Action
                </th>
              </tr>
            </thead>
            <tbody>
              {currentItems &&
                currentItems.map((item) => (
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
                      {item.title}
                    </th>
                    <td align="center" className="px-6 py-4">
                      {item.interaction_type.toUpperCase()}
                    </td>
                    <td align="center" className="px-6 py-4">
                      {item.cool_down} sec.
                    </td>
                    <td align="center" className="px-6 py-4">
                      <button
                        type="button"
                        onClick={handleEditStepClick}
                        data-stepid={item.id}
                      >
                        <AiOutlineEdit className="text-primary-800" size={18} />
                      </button>
                      <button
                        type="button"
                        onClick={handleDeleteJobStep}
                        data-stepid={item.id}
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
        <div className="mt-auto">
          <Pagination
            pageCount={pageCount}
            handlePageChange={handlePageClick}
          />
        </div>
      </div>
      {!editStep && (
        <div>
          <div className="px-2 pt-2 font-medium text-white lg:text-lg flex gap-2 items-center">
            <div>
              <AiOutlinePlusCircle />
            </div>
            <span>Add Job Step</span>
          </div>
          <div className="p-2">
            <AddStepForm Job={Job} onAddJobStep={onAddJobStep} />
          </div>
        </div>
      )}
      {editStep && (
        <div>
          <div className="px-2 pt-2 font-medium text-orange-100 lg:text-lg flex gap-2 items-center">
            <button
              type="button"
              onClick={() => setEditStep(undefined)}
              className="mr-1"
            >
              <BsArrowLeft />
            </button>
            <div>
              <BsDatabaseFillGear />
            </div>
            <span>Edit Job Step [{editStep.title}]</span>
          </div>
          <div className="p-2">
            <EditStepForm
              Job={Job}
              editStep={editStep}
              onUpdateJobStep={onUpdateJobStep}
            />
          </div>
        </div>
      )}
    </>
  );
};

export default JobSteps;
