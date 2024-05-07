import { JobInputProps, JobProps } from "../../types/JobTypes";

export const AddMarketInputs = (Job: JobProps | undefined): JobInputProps[] => [
  {
    type: "text",
    label: "Name",
    uniqueName: "name",
    required: true,
    description: "Short name describing the job market.",
  },
  {
    type: "select",
    label: "Interaction Type",
    uniqueName: "interaction_type",
    required: true,
    description: "Job market npc interaction type",
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
    type: "text",
    label: "Ped Model Hash",
    uniqueName: "ped_model_hash",
    required: true,
    description: "Market Ped model hash.",
    hintLink: "https://docs.fivem.net/docs/game-references/ped-models/",
  },
];
