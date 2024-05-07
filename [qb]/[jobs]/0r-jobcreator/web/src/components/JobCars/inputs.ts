import { JobInputProps, JobProps } from "../../types/JobTypes";

export const AddCarSpawnerInputs = (
  Job: JobProps | undefined
): JobInputProps[] => [
  {
    type: "text",
    label: "Name",
    uniqueName: "name",
    required: true,
    description: "Short name describing the job car spawner.",
  },
  {
    type: "select",
    label: "Interaction Type",
    uniqueName: "interaction_type",
    required: true,
    description: "Spawner interaction type",
    options: [
      { value: "", label: "" },
      {
        value: "target",
        label: `Target (${Job?.target_type})`,
      },
      {
        value: "textui",
        label: `Text UI (${Job?.textui_type})`,
      },
    ],
  },
  {
    type: "coords",
    label: "Coords",
    uniqueName: "coords",
    required: true,
    description: "[x | y | z | heading]",
    hintLink: "Please do not install inside other zones.",
    attributes: {
      useGetCoord: true,
    },
  },
  {
    type: "coords",
    label: "Car Spawner coords",
    uniqueName: "car_spawner_coords",
    required: true,
    description: "[x | y | z | heading]",
    hintLink: "Please do not install inside other zones.",
    attributes: {
      useGetCoord: true,
    },
  },
];
