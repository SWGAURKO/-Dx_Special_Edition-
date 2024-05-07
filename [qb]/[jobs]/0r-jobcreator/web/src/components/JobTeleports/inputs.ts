import { JobInputProps, JobProps } from "../../types/JobTypes";

export const AddTeleportInputs = (
  Job: JobProps | undefined
): JobInputProps[] => [
  {
    type: "text",
    label: "Name",
    uniqueName: "name",
    required: true,
    description: "Short name describing the job teleport.",
  },
  {
    type: "select",
    label: "Interaction Type",
    uniqueName: "interaction_type",
    required: true,
    description: "Job teleport interaction type",
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
    type: "select",
    label: "Teleport Type",
    uniqueName: "type",
    required: true,
    description: "Job teleport type",
    options: [
      { value: "", label: "" },
      {
        value: "one-way",
        label: "One Way",
      },
      {
        value: "two-way",
        label: "Two Way",
      },
    ],
  },
  {
    type: "coords",
    label: "Entry coords",
    uniqueName: "entry_coords",
    required: true,
    description: "[x | y | z | heading]",
    hintLink: "Please do not install inside other zones.",
    attributes: {
      useGetCoord: true,
    },
  },
  {
    type: "coords",
    label: "Exit coords",
    uniqueName: "exit_coords",
    required: true,
    description: "[x | y | z | heading]",
    hintLink: "Please do not install inside other zones.",
    attributes: {
      useGetCoord: true,
    },
  },
];
