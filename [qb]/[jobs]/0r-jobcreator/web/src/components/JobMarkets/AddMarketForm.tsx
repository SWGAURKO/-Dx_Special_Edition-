import { ChangeEvent, useState, useMemo } from "react";
import { MdShareLocation } from "react-icons/md";
import { JobInputProps, JobMarketProps, JobProps } from "../../types/JobTypes";
import { useUtils } from "../../hooks/useUtils";
import { AddMarketInputs } from "./inputs";
import { AiOutlinePlusCircle } from "react-icons/ai";
import { IoMdRemoveCircleOutline } from "react-icons/io";
import { MarketItemProps, vector4Type } from "../../types/useUtilsTypes";

const AddMarketForm = ({
  Job,
  onAddMarket,
}: {
  Job: JobProps;
  onAddMarket: (
    event: React.FormEvent<HTMLFormElement>,
    newMarket: JobMarketProps
  ) => void;
}) => {
  const inputs = useMemo(() => AddMarketInputs(Job ?? undefined), [Job]);
  const [newMarket, setNewMarket] = useState<JobMarketProps>(
    {} as JobMarketProps
  );
  const { getPlayerCoords } = useUtils();
  const [addNewCoord, setAddNewCoord] = useState<vector4Type>({
    x: 0.0,
    y: 0.0,
    z: 0.0,
    h: 0.0,
  });
  const [newMarketItemValues, setNewMarketItemValues] =
    useState<MarketItemProps>({} as MarketItemProps);

  const handleInputChange = (
    e: ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ): void => {
    const { name, value } = e.target;

    setNewMarket((prevMarket) => {
      const updatedMarket = { ...prevMarket };
      const nameParts = name.split(".");
      let currentSection = updatedMarket;
      for (let i = 0; i < nameParts.length; i++) {
        const part = nameParts[i];
        if (i === nameParts.length - 1) {
          currentSection[part] = value;
        } else {
          if (i == 0 && Array.isArray(currentSection[part])) {
            currentSection[part] = {};
          }
          currentSection = currentSection[part] ??= {};
        }
      }
      return updatedMarket;
    });
  };

  const handleGetVector4 = async (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    const playerCoords = await getPlayerCoords();
    setAddNewCoord(playerCoords);
  };

  const handleAddNewPedCoord = (event: React.MouseEvent<HTMLButtonElement>) => {
    event.preventDefault();
    setNewMarket((prevMarket) => ({
      ...prevMarket,
      ped_coords: [...(prevMarket.ped_coords || []), addNewCoord],
    }));
  };

  const handleMarketPedCoordsChange = (
    e: ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    const { name, value } = e.target;
    setAddNewCoord((prevValues) => ({
      ...prevValues,
      [name]: value,
    }));
  };

  const handleNewItemValueChange = (
    e: ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    const { name, value } = e.target;
    e.preventDefault();
    setNewMarketItemValues((prevValues) => {
      return {
        ...prevValues,
        [name]: value,
      };
    });
  };

  const handleRemovePedCoord = (indexToRemove: number) => {
    setNewMarket((prevMarket) => {
      const updatedCoords = prevMarket.ped_coords?.filter(
        (_, index) => index !== indexToRemove
      );
      return {
        ...prevMarket,
        ped_coords: updatedCoords,
      };
    });
  };

  const handleRemoveMarketItem = (indexToRemove: number) => {
    setNewMarket((prevMarket) => {
      const updatedItems = prevMarket.items?.filter(
        (_, index) => index !== indexToRemove
      );
      return {
        ...prevMarket,
        items: updatedItems,
      };
    });
  };

  const handleAddNewItem = async (
    event: React.MouseEvent<HTMLButtonElement>
  ) => {
    event.preventDefault();
    if (
      !newMarketItemValues.amount ||
      !newMarketItemValues.item_name ||
      !newMarketItemValues.label ||
      !newMarketItemValues.money_type ||
      !newMarketItemValues.price ||
      !newMarketItemValues.type
    ) {
      return;
    }
    setNewMarket((prevMarket) => ({
      ...prevMarket,
      items: [...(prevMarket.items || []), newMarketItemValues],
    }));
  };

  function renderInputField(input: JobInputProps) {
    const uniqueId = `add_market_${input.uniqueName.replace(".", "_")}`;
    const part = input.uniqueName;
    const currentMarket: any = newMarket[part];
    const inputValue = currentMarket ?? "";

    return (
      <div key={uniqueId} className={input.className}>
        <label htmlFor={uniqueId} className="block text-primary-100 float-left">
          {input.label}
        </label>
        {input.type === "select" ? (
          <select
            className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
            id={uniqueId}
            name={input.uniqueName}
            value={inputValue}
            onChange={handleInputChange}
            required={input.required}
            {...input.attributes}
          >
            {input.options?.map((option) => (
              <option key={option.value} value={option.value}>
                {option.label}
              </option>
            ))}
          </select>
        ) : (
          <input
            className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
            type={input.type}
            id={uniqueId}
            name={input.uniqueName}
            placeholder={input.label}
            value={inputValue}
            onChange={handleInputChange}
            required={input.required}
            {...input.attributes}
          />
        )}
        <div className="ml-1">
          <span className="text-gray-400 text-xs">* {input.description}</span>
          {input.hintLink && (
            <div>
              <span className="text-gray-400 md:text-xs underline">
                {input.hintLink}
              </span>
            </div>
          )}
        </div>
      </div>
    );
  }

  return (
    <form onSubmit={(event) => onAddMarket(event, newMarket)}>
      <div className="grid gap-4 mb-2 md:grid-cols-3">
        {inputs.map((input: JobInputProps) => renderInputField(input))}
        <div>
          <label
            htmlFor="market_ped_new_coords"
            className="block text-primary-100 float-left"
          >
            <span>Ped Coords</span>
          </label>
          <div className="relative">
            <button
              type="button"
              onClick={handleGetVector4}
              className="text-yellow-500 hover:text-yellow-300 absolute right-0"
              title="Get your current position & heading (vector4)."
            >
              <MdShareLocation size={18} />
            </button>
            <button
              onClick={handleAddNewPedCoord}
              type="button"
              className="text-yellow-500 hover:text-yellow-300 absolute right-6"
              title="Add new coords."
            >
              <AiOutlinePlusCircle size={18} />
            </button>
          </div>
          <div className="grid grid-cols-4 w-full">
            <input
              className="disabled:bg-primary-700 bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block p-2.5 text-center text-primary-100"
              type="number"
              step={0.01}
              name="x"
              placeholder="X"
              required={false}
              onChange={handleMarketPedCoordsChange}
              value={addNewCoord.x}
            />
            <input
              className="disabled:bg-primary-700 bg-primary-900 border border-l-0 border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block p-2.5 text-center text-primary-100"
              type="number"
              step={0.01}
              name="y"
              placeholder="Y"
              required={false}
              onChange={handleMarketPedCoordsChange}
              value={addNewCoord.y}
            />
            <input
              className="disabled:bg-primary-700 bg-primary-900 border border-l-0 border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block p-2.5 text-center text-primary-100"
              type="number"
              step={0.01}
              name="z"
              placeholder="Z"
              required={false}
              onChange={handleMarketPedCoordsChange}
              value={addNewCoord.z}
            />
            <input
              className="disabled:bg-primary-700 bg-primary-900 border border-l-0 border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block p-2.5 text-center text-primary-100"
              type="number"
              step={0.01}
              name="h"
              placeholder="W"
              required={false}
              onChange={handleMarketPedCoordsChange}
              value={addNewCoord.h}
            />
          </div>
          <div className="ml-1">
            <span className="text-gray-400 text-xs">
              * At least one coordinate must be added
            </span>
            <div>
              <span className="text-gray-400 md:text-xs underline">
                Please do not install inside other zones
              </span>
            </div>
          </div>
          {newMarket.ped_coords?.length > 0 && (
            <div
              key="newStep.coords.map"
              className="mt-2 rounded-b bg-primary-900 border border-primary-300 block p-1 text-primary-100 space-y-1"
            >
              {newMarket.ped_coords?.map((coords, index) => (
                <div
                  key={index}
                  className="bg-primary-700 p-1 flex justify-between items-center w-full rounded"
                >
                  <div>
                    ({coords.x}) , ({coords.y}) , ({coords.z})
                  </div>
                  <button
                    type="button"
                    onClick={() => handleRemovePedCoord(index)}
                  >
                    <IoMdRemoveCircleOutline size={18} />
                  </button>
                </div>
              ))}
            </div>
          )}
        </div>
        <div>
          <label
            htmlFor="market_ped_new_coords"
            className="block text-primary-100 float-left"
          >
            <span>Market Items</span>
          </label>
          <div className="relative">
            <button
              onClick={handleAddNewItem}
              type="button"
              className="text-yellow-500 hover:text-yellow-300 absolute right-0"
              title="Add new item."
            >
              <AiOutlinePlusCircle size={18} />
            </button>
          </div>
          <div className="w-full flex flex-col bg-primary-700 p-1 gap-1">
            <div>
              <input
                className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
                type="text"
                placeholder="Item name"
                name="item_name"
                onChange={handleNewItemValueChange}
                value={newMarketItemValues.item_name}
              />
            </div>
            <div>
              <input
                className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
                type="text"
                placeholder="Item Label"
                name="label"
                onChange={handleNewItemValueChange}
                value={newMarketItemValues.label}
              />
            </div>
            <div>
              <select
                className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
                name="type"
                onChange={handleNewItemValueChange}
                value={newMarketItemValues.type}
              >
                <option value={""}>
                  Sell & Buy
                </option>
                <option value="sell">Sell</option>
                <option value="buy">Buy</option>
              </select>
            </div>
            <div>
              <input
                className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
                type="number"
                placeholder="Item Amount"
                min={0}
                max={1000000}
                name="amount"
                onChange={handleNewItemValueChange}
                value={newMarketItemValues.amount}
              />
            </div>
            <div>
              <select
                className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
                name="money_type"
                onChange={handleNewItemValueChange}
                value={newMarketItemValues.money_type}
              >
                <option value={""}>
                  Money Type
                </option>
                <option value="cash">Cash</option>
                <option value="bank">Bank</option>
              </select>
            </div>
            <div>
              <input
                className="bg-primary-900 border border-primary-300 text-sm focus:outline-none focus:ring-0 focus:border-primary-400 block w-full p-2.5 text-primary-100"
                type="number"
                placeholder="Price"
                min={0}
                name="price"
                onChange={handleNewItemValueChange}
                value={newMarketItemValues.price}
              />
            </div>
          </div>
          <div className="ml-1">
            <span className="text-gray-400 text-xs">
              * At least one item must be added
            </span>
          </div>
          {newMarket.items?.length > 0 && (
            <div
              key="newStep.coords.map"
              className="mt-2 rounded-b bg-primary-900 border border-primary-300 block p-1 text-primary-100 space-y-1"
            >
              {newMarket.items?.map((item, index) => (
                <div
                  key={index}
                  className="bg-primary-700 p-1 flex justify-between items-center w-full rounded"
                >
                  <div className="flex flex-col">
                    <span>
                      Item: {item.label.toUpperCase()} ({item.item_name}) (
                      {item.amount}x)
                    </span>
                    <span>
                      [{item.type.toUpperCase()}] {item.price}${" "}
                      {item.money_type.toUpperCase()}
                    </span>
                  </div>
                  <button
                    type="button"
                    onClick={() => handleRemoveMarketItem(index)}
                  >
                    <IoMdRemoveCircleOutline size={18} />
                  </button>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
      <div className="w-full mt-auto">
        <button
          type="submit"
          className="ml-auto flex items-center gap-1 justify-between bg-primary-600 text-primary-100 p-2 px-6 rounded hover:bg-primary-500 transition duration-300 shadow"
        >
          <div>Add</div>
        </button>
      </div>
    </form>
  );
};

export default AddMarketForm;
