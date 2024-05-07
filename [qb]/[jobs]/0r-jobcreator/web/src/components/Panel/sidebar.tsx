import classNames from "classnames";
import React from "react";
import {
  BsFillDatabaseFill,
  BsDatabaseFillAdd,
  BsDatabaseFillGear,
  BsFillCarFrontFill,
} from "react-icons/bs";
import { IconType } from "react-icons";
import { ImListNumbered } from "react-icons/im";
import { LuWarehouse } from "react-icons/lu";
import { GiTeleport } from "react-icons/gi";
import useRouter from "../../hooks/useRouter";
import { PageTypes } from "../../types/RouterProviderTypes";
import { FaRegObjectUngroup } from "react-icons/fa6";
import { AiOutlineShop } from "react-icons/ai";

type ItemProp = {
  title: PageTypes;
  name: string;
  icon: IconType;
  aliases?: Array<string>;
};

const Panel: React.FC = () => {
  const { router, setRouter, editedJobIdentity } = useRouter();

  const items: ItemProp[] = [
    {
      title: "jobs",
      name: "Jobs",
      icon: BsFillDatabaseFill,
    },
    {
      title: "createJob",
      name: "Create Job",
      icon: BsDatabaseFillAdd,
    },
  ];

  const jobItems: ItemProp[] = [
    {
      title: "editJob",
      name: "Edit Job",
      icon: BsDatabaseFillGear,
    },
    {
      title: "jobSteps",
      name: "Job Steps",
      icon: ImListNumbered,
    },
    {
      title: "jobTeleports",
      name: "Teleports",
      icon: GiTeleport,
    },
    {
      title: "jobObjects",
      name: "Job Objects",
      icon: FaRegObjectUngroup,
    },
    {
      title: "jobCars",
      name: "Job Cars",
      icon: BsFillCarFrontFill,
    },
    {
      title: "jobStashes",
      name: "Job Stashes",
      icon: LuWarehouse,
    },
    {
      title: "jobMarkets",
      name: "Job Markets",
      icon: AiOutlineShop,
    },
  ];

  return (
    <aside aria-label="Sidebar" className="h-full">
      <div className="flex flex-col bg-primary-900 border-r border-primary-600 h-full">
        <div className="p-3 overflow-y-auto no-scrollbar">
          <ul className="space-y-2 font-medium w-36">
            {items.map((item) => (
              <li key={item.title}>
                <button
                  type="button"
                  onClick={() => setRouter(item.title)}
                  className={classNames(
                    "w-full flex items-center p-2 rounded text-primary-200 hover:text-white hover:bg-primary-600 transition duration-100 group",
                    {
                      "bg-primary-600 text-white":
                        router === item.title ||
                        (item.aliases && item.aliases.includes(router)),
                    }
                  )}
                >
                  <item.icon
                    className={classNames(
                      "w-5 h-5 text-primary-200 transition duration-100 group-hover:text-white",
                      {
                        "text-white":
                          router === item.title ||
                          (item.aliases && item.aliases.includes(router)),
                      }
                    )}
                  />
                  <span className="ml-3">{item.name}</span>
                </button>
              </li>
            ))}
            <hr className="border-primary-600" />
            {editedJobIdentity != "" && (
              <>
                {jobItems.map((item) => (
                  <li key={item.title}>
                    <button
                      type="button"
                      onClick={() => setRouter(item.title)}
                      className={classNames(
                        "w-full flex items-center p-2 rounded text-primary-200 hover:text-white hover:bg-primary-600 transition duration-100 group",
                        {
                          "bg-primary-600 text-white":
                            router === item.title ||
                            (item.aliases && item.aliases.includes(router)),
                        }
                      )}
                    >
                      <item.icon
                        className={classNames(
                          "w-5 h-5 text-primary-200 transition duration-100 group-hover:text-white",
                          {
                            "text-white":
                              router === item.title ||
                              (item.aliases && item.aliases.includes(router)),
                          }
                        )}
                      />
                      <span className="ml-3">{item.name}</span>
                    </button>
                  </li>
                ))}
              </>
            )}
          </ul>
        </div>
        <div className="border-t border-t-primary-700 p-2 text-center mt-auto">
          <span className="font-medium text-primary-300 hover:text-primary-100 cursor-pointer">
            0-Resmon
          </span>
        </div>
      </div>
    </aside>
  );
};

export default Panel;
