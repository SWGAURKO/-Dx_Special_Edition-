import { useEffect, useState } from "react";
import { BsDatabaseFill } from "react-icons/bs";
import { AiOutlineDoubleRight } from "react-icons/ai";
import Pagination from "../../components/Pagination";
import useData from "../../hooks/useData";
import classNames from "classnames";
import useRouter from "../../hooks/useRouter";
import { JobProps } from "../../types/JobTypes";
import { PaginationProps } from "../../types/useUtilsTypes";

const Jobs = () => {
  const { Jobs } = useData();
  const { setEditedJobIdentity, setRouter } = useRouter();
  const [currentItems, setCurrentItems] = useState<JobProps[]>([]);
  const [pageCount, setPageCount] = useState(0);
  const [itemOffset, setItemOffset] = useState(0);
  const itemsPerPage = 5;

  useEffect(() => {
    const endOffset = itemOffset + itemsPerPage;
    setCurrentItems(Jobs.slice(itemOffset, endOffset));
    setPageCount(Math.ceil(Jobs.length / itemsPerPage));
  }, [itemOffset, Jobs]);

  const handlePageClick = (event: PaginationProps) => {
    const newOffset = (event.selected * itemsPerPage) % Jobs.length;
    setItemOffset(newOffset);
  };

  const handleEditArrowClick = (event: React.MouseEvent<HTMLButtonElement>) => {
    event.preventDefault();
    const jobIdentity = event.currentTarget.dataset.identity;
    if (!jobIdentity) return;
    setEditedJobIdentity(jobIdentity);
    setRouter("editJob");
  };

  return (
    <div className="h-full flex flex-col">
      <div className="p-2 text-white lg:text-lg border-b border-primary-600 flex gap-2 items-center">
        <BsDatabaseFill />
        <span>Jobs</span>
      </div>
      <div className="relative overflow-x-auto p-2 no-scrollbar">
        <table className="w-full text-sm text-left text-primary-700">
          <thead className="text-xs text-primary-100 uppercase bg-primary-500">
            <tr>
              <th scope="col" className="px-6 py-3">
                ID
              </th>
              <th scope="col" className="px-6 py-3">
                Job Name
              </th>
              <th align="center" scope="col" className="px-6 py-3">
                Perm
              </th>
              <th align="center" scope="col" className="px-6 py-3">
                Status
              </th>
              <th align="center" scope="col" className="px-6 py-3">
                Action
              </th>
            </tr>
          </thead>
          <tbody>
            {currentItems &&
              currentItems.map((item, index) => (
                <tr
                  key={item.identity}
                  className={classNames(
                    { "bg-primary-300": index % 2 == 0 },
                    { "bg-primary-200": index % 2 != 0 }
                  )}
                >
                  <th
                    scope="row"
                    className="px-6 py-3 font-medium text-primary-900 whitespace-nowrap"
                  >
                    {item.identity}
                  </th>
                  <th className="px-6 py-3 font-medium text-primary-900 whitespace-nowrap">
                    {item.name}
                  </th>
                  <td align="center" className="px-6 py-4 uppercase">
                    {item.perm?.type != "all"
                      ? item.perm?.type + "|" + item.perm?.name
                      : "All"}
                  </td>
                  <td align="center" className="px-6 py-4">
                    {item.status == "active" ? "Active" : "Deactive"}
                  </td>
                  <td align="center" className="px-6 py-4">
                    <button
                      type="button"
                      onClick={handleEditArrowClick}
                      data-identity={item.identity}
                    >
                      <AiOutlineDoubleRight
                        className="text-primary-800"
                        size={18}
                      />
                    </button>
                  </td>
                </tr>
              ))}
          </tbody>
        </table>
      </div>
      <div className="mt-auto">
        <Pagination pageCount={pageCount} handlePageChange={handlePageClick} />
      </div>
    </div>
  );
};

export default Jobs;
