import { useState, useEffect } from "react";
import useData from "../../hooks/useData";
import useRouter from "../../hooks/useRouter";
import { JobProps, JobMarketProps } from "../../types/JobTypes";
import { BsArrowLeft, BsQuestionOctagon, BsTrash } from "react-icons/bs";
import { AiOutlineEdit, AiOutlinePlusCircle } from "react-icons/ai";
import classNames from "classnames";
import { LuWarehouse } from "react-icons/lu";
import AddMarketForm from "../../components/JobMarkets/AddMarketForm";
import EditMarketForm from "../../components/JobMarkets/EditMarketForm";

const JobMarkets = () => {
  const { Jobs, addJobMarket, updateJobMarket, deleteJobMarket } = useData();
  const { editedJobIdentity, setRouter } = useRouter();
  const [editMarket, setEditMarket] = useState<JobMarketProps | undefined>(
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

  const onAddMarket = async (
    event: React.FormEvent,
    newMarket: JobMarketProps
  ) => {
    event.preventDefault();
    if (
      !newMarket.ped_coords ||
      !newMarket.items ||
      newMarket.ped_coords.length == 0 ||
      newMarket.items.length == 0
    ) {
      return;
    }
    const createdMarket = await addJobMarket(Job.identity, newMarket);
    if (typeof createdMarket !== "boolean") {
      setJob((prevJob) => {
        if (!prevJob) return;
        return {
          ...prevJob,
          markets: [...(prevJob.markets || []), createdMarket],
        };
      });
    }
  };

  const onUpdateMarket = async (
    event: React.FormEvent,
    updateMarket: JobMarketProps
  ) => {
    event.preventDefault();
    const _updateMarket = await updateJobMarket(Job.identity, updateMarket);
    if (typeof _updateMarket !== "boolean") {
      setJob((prevJob) => {
        if (!prevJob) return;
        const updateMarkets = prevJob.markets.map((market) => {
          if (market.id === _updateMarket.id) {
            return {
              ..._updateMarket,
            };
          } else {
            return market;
          }
        });
        return { ...prevJob, markets: updateMarkets };
      });
    }
  };

  const handleDeleteJobMarket = async (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    if (isConfirming) {
      const jobIdentity = Job.identity;
      const { marketid } = event.currentTarget.dataset;
      if (marketid) {
        const result = await deleteJobMarket(jobIdentity, Number(marketid));
        if (result) {
          setRouter("editJob");
        }
        setIsConfirming(false);
      }
    } else {
      setIsConfirming(true);
    }
  };

  const handleEditMarketClick = (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    const { marketid } = event.currentTarget.dataset;
    const market = Job.markets.find((market) => market.id === Number(marketid));
    setEditMarket(market);
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
              <p className="text-sm">Press again to delete the market.</p>
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
        <span>Job Markets [{Job.identity}] </span>
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
            {Job.markets &&
              Job.markets.map((item) => (
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
                      onClick={handleEditMarketClick}
                      data-marketid={item.id}
                    >
                      <AiOutlineEdit className="text-primary-800" size={18} />
                    </button>
                    <button
                      type="button"
                      onClick={handleDeleteJobMarket}
                      data-marketid={item.id}
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
      {!editMarket && (
        <div>
          <div className="px-2 pt-2 font-medium text-white lg:text-lg flex gap-2 items-center">
            <div>
              <AiOutlinePlusCircle />
            </div>
            <span>Add Job Market</span>
          </div>
          <div className="p-2">
            <AddMarketForm Job={Job} onAddMarket={onAddMarket} />
          </div>
        </div>
      )}
      {editMarket && (
        <div>
          <div className="px-2 pt-2 font-medium text-orange-100 lg:text-lg flex gap-2 items-center">
            <button
              type="button"
              onClick={() => setEditMarket(undefined)}
              className="mr-1"
            >
              <BsArrowLeft />
            </button>
            <div>
              <LuWarehouse />
            </div>
            <span>Edit Job Market [{editMarket.name}]</span>
          </div>
          <div className="p-2">
            <EditMarketForm
              Job={Job}
              editMarket={editMarket}
              onUpdateMarket={onUpdateMarket}
            />
          </div>
        </div>
      )}
    </div>
  );
};

export default JobMarkets;
