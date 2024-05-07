export type PageTypes =
  | "jobs"
  | "createJob"
  | "editJob"
  | "jobStashes"
  | "jobTeleports"
  | "jobObjects"
  | "jobCars"
  | "jobMarkets"
  | "jobSteps";

export type RouterProviderProps = {
  router: PageTypes;
  setRouter: (router: PageTypes) => void;
  page: React.ReactNode;
  editedJobIdentity: string;
  setEditedJobIdentity: (jobIdentity: string) => void;
};
