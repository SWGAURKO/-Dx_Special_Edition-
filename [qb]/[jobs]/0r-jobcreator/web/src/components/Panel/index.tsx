import React, { Fragment, ReactNode } from "react";
import { FaUserShield } from "react-icons/fa6";
import { BsTerminal } from "react-icons/bs";
import { Transition } from "@headlessui/react";
import { useVisibility } from "../../hooks/useVisibility";
import useData from "../../hooks/useData";
import SideBar from "./sidebar";

interface PanelProps {
  children: ReactNode;
}

const Panel: React.FC<PanelProps> = ({ children }) => {
  const { visible } = useVisibility();
  const { admin } = useData();

  return (
    <Transition
      as={Fragment}
      show={visible}
      enter="transform transition duration-[400ms]"
      enterFrom="opacity-0 scale-50"
      enterTo="opacity-100 scale-100"
      leave="transform duration-200 transition ease-in-out"
      leaveFrom="opacity-100 scale-100"
      leaveTo="opacity-0 scale-95"
    >
      <div className="container m-auto w-full max-w-screen-lg p-3">
        <div className="bg-primary-800 rounded shadow-lg border border-primary-600">
          <div className="p-3 border-b border-primary-600">
            <div className="flex justify-between items-center align-middle">
              <div>
                <div className="flex justify-center items-center text-center gap-3">
                  <BsTerminal className="text-primary-300" size={24} />
                  <p className="lg:text-base text-white uppercase tracking-wider">
                    Job Creator Panel
                  </p>
                </div>
              </div>
              <div>
                <div className="flex justify-center items-center gap-3">
                  <FaUserShield className="text-primary-300" size={24} />
                  <span className="lg:text-base text-white uppercase tracking-wider">
                    {admin.fullName} [Admin]
                  </span>
                </div>
              </div>
            </div>
          </div>
          <div className="flex items-start h-[640px]">
            <div className="h-full">
              <SideBar />
            </div>
            <div className="flex-auto h-full overflow-y-auto no-scrollbar">
              {children}
            </div>
          </div>
        </div>
      </div>
    </Transition>
  );
};

export default Panel;
