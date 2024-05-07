import React, { createContext, useState, useEffect } from "react";
import {
  AddJobCarSpawnerProps,
  AddJobMarketProps,
  AddJobObjectProps,
  AddJobStashProps,
  AddJobStepProps,
  AddJobTeleportProps,
  AdminProp,
  CreateNewJobProps,
  DataContextProps,
  DeleteJobByIdentityProps,
  DeleteJobMarketProps,
  DeleteJobObjectProps,
  DeleteJobStashProps,
  DeleteJobStepProps,
  UpdateJobCarSpawnerProps,
  UpdateJobMainSettingsProps,
  UpdateJobMarketProps,
  UpdateJobObjectProps,
  UpdateJobStashProps,
  UpdateJobStatusByIdentityProps,
  UpdateJobStepProps,
  UpdateJobTeleportProps,
} from "../types/DataProviderTypes";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import { debugLog, isEnvBrowser } from "../utils/misc";
import { JobProps, ReactChildren } from "../types/JobTypes";
import useRouter from "../hooks/useRouter";
import { useVisibility } from "../hooks/useVisibility";

export const DataCtx = createContext<DataContextProps>({} as DataContextProps);

export const DataProvider: React.FC<ReactChildren> = ({ children }) => {
  const [admin, setAdmin] = useState<AdminProp>({} as AdminProp);
  const [Jobs, setJobs] = useState<JobProps[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const { setEditedJobIdentity, setRouter } = useRouter();
  const { visible } = useVisibility();

  useEffect(() => {
    if (isLoading) {
      const timeoutId = setTimeout(() => {
        setIsLoading(false);
      }, 1000);
      return () => {
        clearTimeout(timeoutId);
      };
    }
  }, [isLoading]);

  useEffect(() => {
    if (!isEnvBrowser() && visible) {
      fetchNui<JobProps[]>("job-creator/getAllJobs")
        .then((jobs) => {
          const updatedJobs = Object.values(jobs);
          updatedJobs.forEach((element) => {
            element.steps =
              (typeof element.steps == "object" &&
                Object.values(element.steps)) ||
              element.steps;
            element.teleports =
              (typeof element.teleports == "object" &&
                Object.values(element.teleports)) ||
              element.teleports;
            element.objects =
              (typeof element.objects == "object" &&
                Object.values(element.objects)) ||
              element.objects;
            element.carSpawners =
              (typeof element.carSpawners == "object" &&
                Object.values(element.carSpawners)) ||
              element.carSpawners;
            element.stashes =
              (typeof element.stashes == "object" &&
                Object.values(element.stashes)) ||
              element.stashes;
            element.markets =
              (typeof element.markets == "object" &&
                Object.values(element.markets)) ||
              element.markets;
          });
          setJobs(updatedJobs);
        })
        .catch((error) => {
          debugLog(error, "job-creator/getAllJobs");
        });
    } else if (isEnvBrowser() && visible) {
      setJobs([
        {
          name: "test",
          unique_name: "test",
          perm: {
            type: "all",
          },
          notify_type: "qb_notify",
          target_type: "no_target",
          textui_type: "no_textui",
          progressbar_type: "no_progressbar",
          menu_type: "no_menu",
          skillbar_type: "no_skillbar",
          identity: "yo8d5",
          author: "ali",
          steps: [],
          status: "deactive",
          teleports: [],
          objects: [],
          carSpawners: [],
          stashes: [],
          markets: [],
        },
      ]);
    }
  }, [visible]);

  useNuiEvent<AdminProp>("setPlayerData", (data) => {
    setAdmin(data);
  });

  const createNewJob: CreateNewJobProps = async (data) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui<any>("job-creator/new", data, {
        newJob: {
          ...data,
          identity: (Math.random() + 1).toString(36).substring(7),
          unique_name: data.name,
          author: "alikoc",
          status: "deactive",
          start_type: null,
          blip: {},
          start_ped: {},
          steps: [],
          teleports: [],
          objects: [],
          carSpawners: [],
        },
      });
      if (response.newJob) {
        const updatedJobs = [...Jobs, response.newJob];
        setJobs(updatedJobs);
        setEditedJobIdentity(response.newJob.identity);
        setRouter("editJob");
        return response.newJob;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/new");
    } finally {
      setIsLoading(true);
    }
  };

  const updateJobMainSettings: UpdateJobMainSettingsProps = async (job) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui(
        "job-creator/updateJobMainSettings",
        {
          identity: job.identity,
          name: job.name,
          perm: job.perm,
          notify_type: job.notify_type,
          progressbar_type: job.progressbar_type,
          skillbar_type: job.skillbar_type,
          menu_type: job.menu_type,
          target_type: job.target_type,
          textui_type: job.textui_type,
          start_type: job.start_type,
          start_ped: job.start_ped,
          blip: job.blip,
          status: job.status,
        },
        {
          updatedJob: job,
        }
      );
      if (response.updatedJob) {
        setJobs((prevJobs) => {
          const updatedJobIdentity = response.updatedJob.identity;
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === updatedJobIdentity) {
              const updatedJob = response.updatedJob;
              return {
                ...job,
                name: updatedJob.name,
                perm: updatedJob.perm,
                notify_type: updatedJob.notify_type,
                progressbar_type: updatedJob.progressbar_type,
                skillbar_type: updatedJob.skillbar_type,
                menu_type: updatedJob.menu_type,
                target_type: updatedJob.target_type,
                textui_type: updatedJob.textui_type,
                start_type: updatedJob.start_type,
                start_ped: updatedJob.start_ped,
                blip: updatedJob.blip,
              };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.updatedJob;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/updateJobMainSettings");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const updateJobStatusByIdentity: UpdateJobStatusByIdentityProps = async (
    identity,
    checked
  ) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui<any>(
        "job-creator/updateJobStatusByIdentity",
        {
          identity: identity,
          status: checked,
        },
        {
          newStatus: checked ? "active" : "deactive",
        }
      );
      if (response.newStatus) {
        setJobs((prevJobs) => {
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === identity) {
              return { ...job, status: response.newStatus };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.newStatus;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/updateJobStatusByIdentity");
    } finally {
      setIsLoading(true);
    }
  };

  const deleteJobByIdentity: DeleteJobByIdentityProps = async (jobIdentity) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui<any>(
        "job-creator/deleteJob",
        jobIdentity,
        true
      );
      if (response) {
        setJobs((prevJob) =>
          prevJob.filter((job) => job.identity !== jobIdentity)
        );
        setEditedJobIdentity("");
        return true;
      }
      return false;
    } catch (error) {
      debugLog(error, "job/creator/deleteJobByIdentity");
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  const addJobStep: AddJobStepProps = async (jobIdentity, newStep) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui(
        "job-creator/addNewJobStep",
        {
          jobIdentity: jobIdentity,
          newStep: newStep,
        },
        {
          newStep: {
            ...newStep,
            id: Math.floor(Math.random() * 900) + 100,
            author: "alikoc",
            job_identity: jobIdentity,
          },
        }
      );
      if (response.newStep) {
        setJobs((prevJobs) => {
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === jobIdentity) {
              return { ...job, steps: [...job.steps, response.newStep] };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.newStep;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/addNewJobStep");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const updateJobStep: UpdateJobStepProps = async (
    jobIdentity,
    updatedStep
  ) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui(
        "job-creator/updateJobStep",
        {
          jobIdentity: jobIdentity,
          stepId: updatedStep.id,
          updatedStep: updatedStep,
        },
        {
          updatedStep: updatedStep,
        }
      );
      if (response.updatedStep) {
        setJobs((prevJobs) => {
          const updatedJobIdentity = jobIdentity;
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === updatedJobIdentity) {
              const updatedSteps = job.steps.map((step) => {
                if (step.id === response.updatedStep.id) {
                  return { ...response.updatedStep };
                } else {
                  return step;
                }
              });
              return { ...job, steps: updatedSteps };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.updatedStep;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/updateJobStep");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const deleteJobStep: DeleteJobStepProps = async (jobIdentity, stepId) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui<any>(
        "job-creator/deleteJobStep",
        { jobIdentity: jobIdentity, stepId: stepId },
        true
      );
      if (response) {
        setJobs((prevJobs) => {
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === jobIdentity) {
              const updatedSteps = job.steps.filter(
                (step) => step.id !== stepId
              );
              return { ...job, steps: updatedSteps };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return true;
      }
      return false;
    } catch (error) {
      debugLog(error, "job/creator/deleteJobStepByIdentity");
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  // -- @ --
  const addJobTeleport: AddJobTeleportProps = async (
    jobIdentity,
    newTeleport
  ) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui(
        "job-creator/addNewJobTeleport",
        {
          jobIdentity: jobIdentity,
          newTeleport: newTeleport,
        },
        {
          newTeleport: {
            ...newTeleport,
            id: Math.floor(Math.random() * 900) + 100,
            author: "alikoc",
            job_identity: jobIdentity,
          },
        }
      );
      if (response.newTeleport) {
        setJobs((prevJobs) => {
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === jobIdentity) {
              return {
                ...job,
                teleports: [...job.teleports, response.newTeleport],
              };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.newTeleport;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/addNewJobTeleport");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const updateJobTeleport: UpdateJobTeleportProps = async (
    jobIdentity,
    updatedTeleport
  ) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui(
        "job-creator/updateJobTeleport",
        {
          jobIdentity: jobIdentity,
          teleportId: updatedTeleport.id,
          updatedTeleport: updatedTeleport,
        },
        {
          updatedTeleport: updatedTeleport,
        }
      );
      if (response.updatedTeleport) {
        setJobs((prevJobs) => {
          const updatedJobIdentity = jobIdentity;
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === updatedJobIdentity) {
              const updatedTeleports = job.teleports.map((teleport) => {
                if (teleport.id === response.updatedTeleport.id) {
                  return { ...response.updatedTeleport };
                } else {
                  return teleport;
                }
              });
              return { ...job, teleports: updatedTeleports };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.updatedTeleport;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/updateJobTeleport");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const addJobObject: AddJobObjectProps = async (jobIdentity, newObject) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui(
        "job-creator/addNewJobObject",
        {
          jobIdentity: jobIdentity,
          newObject: newObject,
        },
        {
          newObject: {
            ...newObject,
            id: Math.floor(Math.random() * 900) + 100,
            author: "alikoc",
            job_identity: jobIdentity,
          },
        }
      );
      if (response.newObject) {
        setJobs((prevJobs) => {
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === jobIdentity) {
              return {
                ...job,
                objects: [...job.objects, response.newObject],
              };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.newObject;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/addNewJobObject");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const updateJobObject: UpdateJobObjectProps = async (
    jobIdentity,
    updatedObject
  ) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui(
        "job-creator/updateJobObject",
        {
          jobIdentity: jobIdentity,
          objectId: updatedObject.id,
          updatedObject: updatedObject,
        },
        {
          updatedObject: updatedObject,
        }
      );
      if (response.updatedObject) {
        setJobs((prevJobs) => {
          const updatedJobIdentity = jobIdentity;
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === updatedJobIdentity) {
              const updatedObjects = job.objects.map((object) => {
                if (object.id === response.updatedObject.id) {
                  return { ...response.updatedObject };
                } else {
                  return object;
                }
              });
              return { ...job, objects: updatedObjects };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.updatedObject;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/updateJobObject");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const deleteJobObject: DeleteJobObjectProps = async (
    jobIdentity,
    objectId
  ) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui<any>(
        "job-creator/deleteJobObject",
        { jobIdentity: jobIdentity, objectId: objectId },
        true
      );
      if (response) {
        setJobs((prevJobs) => {
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === jobIdentity) {
              const updatedObjects = job.objects.filter(
                (object) => object.id !== objectId
              );
              return { ...job, objects: updatedObjects };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return true;
      }
      return false;
    } catch (error) {
      debugLog(error, "job/creator/deleteJobObjectByIdentity");
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  const addJobCarSpawner: AddJobCarSpawnerProps = async (
    jobIdentity,
    newCarSpawner
  ) => {
    if (isLoading) return false;
    try {
      if (newCarSpawner.cars?.length == 0) return false;
      const response = await fetchNui(
        "job-creator/addNewJobCarSpawner",
        {
          jobIdentity: jobIdentity,
          newCarSpawner: newCarSpawner,
        },
        {
          newCarSpawner: {
            ...newCarSpawner,
            id: Math.floor(Math.random() * 900) + 100,
            author: "alikoc",
            job_identity: jobIdentity,
          },
        }
      );
      if (response.newCarSpawner) {
        setJobs((prevJobs) => {
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === jobIdentity) {
              return {
                ...job,
                carSpawners: [...job.carSpawners, response.newCarSpawner],
              };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.newCarSpawner;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/addNewJobCarSpawner");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const updateJobCarSpawner: UpdateJobCarSpawnerProps = async (
    jobIdentity,
    updatedCarSpawner
  ) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui(
        "job-creator/updateJobCarSpawner",
        {
          jobIdentity: jobIdentity,
          carSpawnerId: updatedCarSpawner.id,
          updatedCarSpawner: updatedCarSpawner,
        },
        {
          updatedCarSpawner: updatedCarSpawner,
        }
      );
      if (response.updatedCarSpawner) {
        setJobs((prevJobs) => {
          const updatedJobIdentity = jobIdentity;
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === updatedJobIdentity) {
              const updatedCarSpawners = job.carSpawners.map((carSpawner) => {
                if (carSpawner.id === response.updatedCarSpawner.id) {
                  return { ...response.updatedCarSpawner };
                } else {
                  return carSpawner;
                }
              });
              return { ...job, carSpawners: updatedCarSpawners };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.updatedCarSpawner;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/updateJobCarSpawner");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const addJobStash: AddJobStashProps = async (jobIdentity, newStash) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui(
        "job-creator/addNewJobStash",
        {
          jobIdentity: jobIdentity,
          newStash: newStash,
        },
        {
          newStash: {
            ...newStash,
            id: Math.floor(Math.random() * 900) + 100,
            author: "alikoc",
            job_identity: jobIdentity,
          },
        }
      );
      if (response.newStash) {
        setJobs((prevJobs) => {
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === jobIdentity) {
              return {
                ...job,
                stashes: [...job.stashes, response.newStash],
              };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.newStash;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/addNewJobStash");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const updateJobStash: UpdateJobStashProps = async (
    jobIdentity,
    updatedStash
  ) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui(
        "job-creator/updateJobStash",
        {
          jobIdentity: jobIdentity,
          stashId: updatedStash.id,
          updatedStash: updatedStash,
        },
        {
          updatedStash: updatedStash,
        }
      );
      if (response.updatedStash) {
        setJobs((prevJobs) => {
          const updatedJobIdentity = jobIdentity;
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === updatedJobIdentity) {
              const updatedStashes = job.stashes.map((stash) => {
                if (stash.id === response.updatedStash.id) {
                  return { ...response.updatedStash };
                } else {
                  return stash;
                }
              });
              return { ...job, stashes: updatedStashes };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.updatedStash;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/updateJobStash");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const deleteJobStash: DeleteJobStashProps = async (jobIdentity, stashId) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui<any>(
        "job-creator/deleteJobStash",
        { jobIdentity: jobIdentity, stashId: stashId },
        true
      );
      if (response) {
        setJobs((prevJobs) => {
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === jobIdentity) {
              const updatedStashes = job.stashes.filter(
                (stash) => stash.id !== stashId
              );
              return { ...job, stashes: updatedStashes };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return true;
      }
      return false;
    } catch (error) {
      debugLog(error, "job/creator/deleteJobStashByIdentity");
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  const addJobMarket: AddJobMarketProps = async (jobIdentity, newMarket) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui(
        "job-creator/addNewJobMarket",
        {
          jobIdentity: jobIdentity,
          newMarket: newMarket,
        },
        {
          newMarket: {
            ...newMarket,
            id: Math.floor(Math.random() * 900) + 100,
            author: "alikoc",
            job_identity: jobIdentity,
          },
        }
      );
      if (response.newMarket) {
        setJobs((prevJobs) => {
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === jobIdentity) {
              return {
                ...job,
                markets: [...job.markets, response.newMarket],
              };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.newMarket;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/addNewJobMarket");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const updateJobMarket: UpdateJobMarketProps = async (
    jobIdentity,
    updatedMarket
  ) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui(
        "job-creator/updateJobMarket",
        {
          jobIdentity: jobIdentity,
          marketId: updatedMarket.id,
          updatedMarket: updatedMarket,
        },
        {
          updatedMarket: updatedMarket,
        }
      );
      if (response.updatedMarket) {
        setJobs((prevJobs) => {
          const updatedJobIdentity = jobIdentity;
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === updatedJobIdentity) {
              const updatedMarkets = job.markets.map((market) => {
                if (market.id === response.updatedMarket.id) {
                  return { ...response.updatedMarket };
                } else {
                  return market;
                }
              });
              return { ...job, markets: updatedMarkets };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return response.updatedMarket;
      }
      return false;
    } catch (error) {
      debugLog(error, "job-creator/updateJobMarket");
      return false;
    } finally {
      setIsLoading(true);
    }
  };

  const deleteJobMarket: DeleteJobMarketProps = async (
    jobIdentity,
    marketId
  ) => {
    if (isLoading) return false;
    try {
      const response = await fetchNui<any>(
        "job-creator/deleteJobMarket",
        { jobIdentity: jobIdentity, marketId: marketId },
        true
      );
      if (response) {
        setJobs((prevJobs) => {
          const updatedJobs = prevJobs.map((job) => {
            if (job.identity === jobIdentity) {
              const updatedMarkets = job.markets.filter(
                (market) => market.id !== marketId
              );
              return { ...job, markets: updatedMarkets };
            } else {
              return job;
            }
          });
          return updatedJobs;
        });
        return true;
      }
      return false;
    } catch (error) {
      debugLog(error, "job/creator/deleteJobMarketByIdentity");
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  const value = {
    isLoading,
    admin,
    Jobs,
    setJobs,
    createNewJob,
    updateJobStatusByIdentity,
    updateJobMainSettings,
    deleteJobByIdentity,
    addJobStep,
    updateJobStep,
    deleteJobStep,
    addJobTeleport,
    updateJobTeleport,
    addJobObject,
    updateJobObject,
    deleteJobObject,
    addJobCarSpawner,
    updateJobCarSpawner,
    addJobStash,
    updateJobStash,
    deleteJobStash,
    addJobMarket,
    updateJobMarket,
    deleteJobMarket,
  };

  return <DataCtx.Provider value={value}>{children}</DataCtx.Provider>;
};
