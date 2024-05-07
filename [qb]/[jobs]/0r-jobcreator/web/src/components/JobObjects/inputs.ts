import { JobInputProps } from "../../types/JobTypes";

export const AddObjectInputs: JobInputProps[] = [
  {
    type: "text",
    label: "Name",
    uniqueName: "name",
    required: true,
    description: "Short name describing the job object.",
  },
  {
    type: "select",
    label: "Type",
    uniqueName: "type",
    required: true,
    description: "Object / Ped",
    options: [
      { value: "", label: "" },
      { value: "object", label: "Object" },
      { value: "ped", label: "Ped" },
    ],
  },
  {
    type: "text",
    label: "Model Hash",
    uniqueName: "model_hash",
    required: true,
    description: "Object/Ped model hash.",
    hintLink: "https://gta-objects.xyz/",
  },
  {
    type: "select",
    label: "Is Network",
    uniqueName: "is_network",
    required: true,
    description: "If no, the object exists only locally.",
    options: [
      { value: "", label: "" },
      { value: "yes", label: "Yes" },
      { value: "no", label: "No" },
    ],
  },
  {
    type: "select",
    label: "Net Mission Entity",
    uniqueName: "net_mission_entity",
    required: true,
    description:
      "Whether to register the object as pinned to the script host in the R* network model.",
    options: [
      { value: "", label: "" },
      { value: "yes", label: "Yes" },
      { value: "no", label: "No" },
    ],
  },
  {
    type: "select",
    label: "Door Flag",
    uniqueName: "door_flag",
    required: true,
    description: "Door flag.",
    hintLink: "https://docs.fivem.net/natives/?_0x509D5878EB39E842",
    options: [
      { value: "", label: "" },
      { value: "yes", label: "Yes" },
      { value: "no", label: "No" },
    ],
  },
  {
    type: "coords",
    label: "Coords",
    uniqueName: "coords",
    description: "[x | y | z | heading]",
    hintLink: "Please do not install inside other zones.",
    required: true,
    attributes: {
      useGetCoord: true,
    },
  },
];
