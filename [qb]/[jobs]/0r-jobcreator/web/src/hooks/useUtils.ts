import { vector4Type } from "../types/useUtilsTypes";
import { fetchNui } from "../utils/fetchNui";
import { debugLog } from "../utils/misc";

export const useUtils = () => {
  const getPlayerCoords = async (): Promise<vector4Type> => {
    try {
      const response = await fetchNui(
        "job-creator/getCurrentLocationCoords",
        null,
        { coords: { x: 1.1, y: 2.2, z: 3.3, h: 4.4 } }
      );
      if (response.coords) {
        return response.coords;
      } else {
        throw new Error("Response has no 'coords' property.");
      }
    } catch (reason) {
      debugLog(reason, "useUtils");
      throw reason;
    }
  };

  return {
    getPlayerCoords,
  };
};
