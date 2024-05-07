import React, { createContext, useEffect, useMemo, useState } from "react";
import Home from "../pages/Dashboard";
import Jobs from "../pages/Jobs";
import CreateJob from "../pages/CreateJob";
import EditJob from "../pages/EditJob";
import { PageTypes, RouterProviderProps } from "../types/RouterProviderTypes";
import JobSteps from "../pages/JobSteps";
import JobTeleports from "../pages/JobTeleports";
import JobObjects from "../pages/JobObjects";
import JobCars from "../pages/JobCars";
import JobStashes from "../pages/JobStashes";
import JobMarkets from "../pages/JobMarkets";

export const RouterCtx = createContext<RouterProviderProps>(
  {} as RouterProviderProps
);

export const RouterProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [router, setRouter] = useState<PageTypes>("jobs");
  const [page, setPage] = useState<React.ReactNode | null>(null);
  const [editedJobIdentity, setEditedJobIdentity] = useState<string>("");

  useEffect(() => {
    if (router == "jobs") setPage(<Jobs />);
    else if (router == "createJob") setPage(<CreateJob />);
    else if (router == "editJob") setPage(<EditJob />);
    else if (router == "jobSteps") setPage(<JobSteps />);
    else if (router == "jobTeleports") setPage(<JobTeleports />);
    else if (router == "jobObjects") setPage(<JobObjects />);
    else if (router == "jobCars") setPage(<JobCars />);
    else if (router == "jobStashes") setPage(<JobStashes />);
    else if (router == "jobMarkets") setPage(<JobMarkets />);
    else setPage(<Home />);
  }, [router]);

  useEffect(() => {
    if (["createJob", "jobs"].includes(router)) {
      setEditedJobIdentity("");
    }
  }, [router]);

  const value = useMemo(() => {
    return {
      router,
      setRouter,
      page,
      setEditedJobIdentity,
      editedJobIdentity,
    };
  }, [router, page, editedJobIdentity]);

  return <RouterCtx.Provider value={value}>{children}</RouterCtx.Provider>;
};

export default RouterProvider;
