import { useContext } from "react";
import { DataCtx } from "../providers/DataProvider";
import { DataContextProps } from "../types/DataProviderTypes";

const useData = (): DataContextProps => {
  const dataContext = useContext(DataCtx);
  return dataContext;
};

export default useData;
