import { CreateJobInputs } from "../CreateJob/inputs";
import { JobInputProps, JobProps } from "../../types/JobTypes";

export const EditJobInputs = (Job: JobProps | undefined): JobInputProps[] => [
  ...CreateJobInputs,
  {
    type: "select",
    label: "Blip",
    uniqueName: "blip.is_required",
    required: true,
    description: "Create a blip for this job (if start type is ped.)",
    options: [
      { value: "", label: "" },
      { value: "yes", label: "Yes" },
      { value: "no", label: "No" },
    ],
  },
  {
    type: "number",
    label: "[Blip] Scale",
    uniqueName: "blip.scale",
    required: true,
    description: "Blip scale (float)",
    showWhen(job) {
      return job.blip?.is_required === "yes";
    },
    attributes: {
      step: "0.01",
      min: "0.01",
    },
  },
  {
    type: "number",
    label: "[Blip] Sprite",
    uniqueName: "blip.sprite",
    required: true,
    description: "Blip sprite (number)",
    hintLink: "https://docs.fivem.net/docs/game-references/blips/",
    showWhen(job) {
      return job.blip?.is_required === "yes";
    },
  },
  {
    type: "number",
    label: "[Blip] Color",
    uniqueName: "blip.color",
    required: true,
    description: "Blip color (number)",
    hintLink: "https://docs.fivem.net/docs/game-references/blips/#blip-colors",
    showWhen(job) {
      return job.blip?.is_required === "yes";
    },
  },
  {
    type: "text",
    label: "[Blip] Name",
    uniqueName: "blip.name",
    required: true,
    description: "Blip name",
    showWhen(job) {
      return job.blip?.is_required === "yes";
    },
  },
  {
    type: "select",
    label: "Start Type",
    uniqueName: "start_type",
    required: true,
    description: "Type of job start",
    options: [
      { value: "", label: "" },
      {
        label: "Interact Ped & Accept",
        value: "ped",
      },
      {
        label: "Always Active",
        value: "always_active",
      },
    ],
  },
  {
    type: "select",
    label: "[Start Type] Ped Interaction",
    uniqueName: "start_ped.interaction_type",
    required: true,
    description: "Ped Interaction Type",
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
    showWhen: (job) => job.start_type === "ped",
  },
  {
    type: "text",
    label: "[Start Type] Ped Model",
    uniqueName: "start_ped.model",
    required: true,
    description: "Ped Model Hash",
    hintLink: "https://docs.fivem.net/docs/game-references/ped-models/",
    showWhen: (job) => job.start_type === "ped",
  },
  {
    type: "coords",
    label: "[Start Type] Coords",
    uniqueName: "start_ped.coords",
    required: true,
    description: "Ped Coords [x | y | z | heading]",
    attributes: {
      useGetCoord: true,
    },
    showWhen: (job) => job.start_type === "ped",
  },
];
