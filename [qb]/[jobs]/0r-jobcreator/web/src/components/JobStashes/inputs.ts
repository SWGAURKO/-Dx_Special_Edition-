import { JobInputProps, JobProps } from "../../types/JobTypes";

export const AddStashInputs = (Job: JobProps | undefined): JobInputProps[] => [
  {
    type: "text",
    label: "Name",
    uniqueName: "name",
    required: true,
    description: "Short name describing the job stash.",
  },
  {
    type: "select",
    label: "Interaction Type",
    uniqueName: "interaction_type",
    required: true,
    description: "Job stash interaction type",
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
    type: "number",
    label: "Size",
    uniqueName: "size",
    required: true,
    description: "Stash size",
    attributes: {
      min: 1,
    },
  },
  {
    type: "number",
    label: "Slots",
    uniqueName: "slots",
    required: true,
    description: "Stash slots",
    attributes: {
      min: 1,
      max: 250,
    },
  },
];
