import {
  JobCarSpawnerProps,
  JobMarketProps,
  JobObjectProps,
  JobProps,
  JobStashProps,
  JobStepProps,
  JobTeleportProps,
} from "./JobTypes";

export type AdminProp = {
  fullName: string;
};

export type CreateNewJobProps = (
  newJob: JobProps
) => Promise<JobProps | boolean>;

export type UpdateJobStatusByIdentityProps = (
  identity: string,
  checked: boolean
) => Promise<"active" | "deactive">;

export type UpdateJobMainSettingsProps = (
  job: JobProps
) => Promise<JobProps | boolean>;

export type DeleteJobByIdentityProps = (
  jobIdentity: string
) => Promise<boolean>;

export type AddJobStepProps = (
  jobIdentity: string,
  newStep: JobStepProps
) => Promise<JobStepProps | boolean>;

export type UpdateJobStepProps = (
  jobIdentity: string,
  updatedstep: JobStepProps
) => Promise<JobStepProps | boolean>;

export type DeleteJobStepProps = (
  jobIdentity: string,
  stepId: number
) => Promise<boolean>;

export type AddJobTeleportProps = (
  jobIdentity: string,
  newTeleport: JobTeleportProps
) => Promise<JobTeleportProps | boolean>;

export type UpdateJobTeleportProps = (
  jobIdentity: string,
  updatedTeleport: JobTeleportProps
) => Promise<JobTeleportProps | boolean>;

export type AddJobObjectProps = (
  jobIdentity: string,
  newObject: JobObjectProps
) => Promise<JobObjectProps | boolean>;

export type UpdateJobObjectProps = (
  jobIdentity: string,
  updatedObject: JobObjectProps
) => Promise<JobObjectProps | boolean>;

export type DeleteJobObjectProps = (
  jobIdentity: string,
  objectId: number
) => Promise<boolean>;

export type AddJobCarSpawnerProps = (
  jobIdentity: string,
  newCarSpawner: JobCarSpawnerProps
) => Promise<JobCarSpawnerProps | boolean>;

export type UpdateJobCarSpawnerProps = (
  jobIdentity: string,
  updatedCarSpawner: JobCarSpawnerProps
) => Promise<JobCarSpawnerProps | boolean>;

export type AddJobStashProps = (
  jobIdentity: string,
  newStash: JobStashProps
) => Promise<JobStashProps | boolean>;

export type UpdateJobStashProps = (
  jobIdentity: string,
  updatedStash: JobStashProps
) => Promise<JobStashProps | boolean>;

export type DeleteJobStashProps = (
  jobIdentity: string,
  stashId: number
) => Promise<boolean>;

export type AddJobMarketProps = (
  jobIdentity: string,
  newMarket: JobMarketProps
) => Promise<JobMarketProps | boolean>;

export type UpdateJobMarketProps = (
  jobIdentity: string,
  updatedMarket: JobMarketProps
) => Promise<JobMarketProps | boolean>;

export type DeleteJobMarketProps = (
  jobIdentity: string,
  marketId: number
) => Promise<boolean>;
export type DataContextProps = {
  admin: AdminProp;
  Jobs: JobProps[];
  setJobs: React.Dispatch<React.SetStateAction<JobProps[]>>;
  createNewJob: CreateNewJobProps;
  updateJobStatusByIdentity: UpdateJobStatusByIdentityProps;
  updateJobMainSettings: UpdateJobMainSettingsProps;
  deleteJobByIdentity: DeleteJobByIdentityProps;
  addJobStep: AddJobStepProps;
  updateJobStep: UpdateJobStepProps;
  deleteJobStep: DeleteJobStepProps;
  // -- @ --
  addJobTeleport: AddJobTeleportProps;
  updateJobTeleport: UpdateJobTeleportProps;
  addJobObject: AddJobObjectProps;
  updateJobObject: UpdateJobObjectProps;
  deleteJobObject: DeleteJobObjectProps;
  addJobCarSpawner: AddJobCarSpawnerProps;
  updateJobCarSpawner: UpdateJobCarSpawnerProps;
  addJobStash: AddJobStashProps;
  updateJobStash: UpdateJobStashProps;
  deleteJobStash: DeleteJobStashProps;
  addJobMarket: AddJobMarketProps;
  updateJobMarket: UpdateJobMarketProps;
  deleteJobMarket: DeleteJobMarketProps;
};
