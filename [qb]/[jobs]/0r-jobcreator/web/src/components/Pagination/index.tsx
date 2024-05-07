import ReactPaginate from "react-paginate";
import { FC } from "react";

interface PaginationProps {
  pageCount: number;
  handlePageChange: (selectedItem: { selected: number }) => void;
}

const Pagination: FC<PaginationProps> = ({ pageCount, handlePageChange }) => {
  return (
    <ReactPaginate
      nextLabel="Next"
      pageRangeDisplayed={3}
      marginPagesDisplayed={2}
      pageCount={pageCount}
      containerClassName="flex items-center justify-center gap-2 m-3 mt-0"
      previousLabel="Previous"
      pageLinkClassName="text-primary-800 rounded-full h-8 w-8 flex items-center text-white justify-center"
      previousLinkClassName="bg-primary-400 p-2 rounded text-primary-800 hover:bg-primary-300"
      nextLinkClassName="bg-primary-400 p-2 rounded text-primary-800 hover:bg-primary-300"
      breakLabel="..."
      breakClassName="w-7 h-7 flex items-center text-gray-400 pb-2"
      activeLinkClassName="border bg-primary-500"
      disabledLinkClassName="bg-primary-600 hover:bg-primary-600 cursor-not-allowed"
      renderOnZeroPageCount={null}
      onPageChange={handlePageChange}
    />
  );
};

export default Pagination;
