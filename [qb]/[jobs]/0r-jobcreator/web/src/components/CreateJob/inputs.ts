import { JobInputProps } from "../../types/JobTypes";

export const CreateJobInputs: JobInputProps[] = [
  {
    type: "text",
    label: "Job Name",
    uniqueName: "name",
    required: true,
    description: "Name of the job",
  },
  {
    type: "select",
    label: "Job Perm Type",
    uniqueName: "perm.type",
    required: true,
    description: "Permission name to do the work.",
    options: [
      {
        label: "",
        value: "",
      },
      {
        label: "All",
        value: "all",
      },
      {
        label: "Job",
        value: "job",
      },
      {
        label: "Gang",
        value: "gang",
      },
    ],
  },
  {
    type: "text",
    label: "Job/Gang Name",
    uniqueName: "perm.name",
    required: true,
    description: "Job or Gang Name",
    showWhen(item) {
      return item.perm && item.perm?.type !== "all";
    },
  },
  {
    type: "select",
    label: "Notify Type",
    uniqueName: "notify_type",
    required: true,
    description: "The Plugin used for Notifications",
    options: [
      {
        label: "",
        value: "",
      },
      {
        label: "QB Notify",
        value: "qb_notify",
      },
      {
        label: "OX-LIB Notify",
        value: "ox_notify",
      },
      {
        label: "OKOK Notify",
        value: "okok_notify",
      },
      {
        label: "Custom Notify (Must be set in Config)",
        value: "custom_notify",
      },
    ],
  },
  {
    type: "select",
    label: "Target Type",
    uniqueName: "target_type",
    required: true,
    description: "The Target plugin.",
    options: [
      {
        label: "",
        value: "",
      },
      {
        label: "No Target",
        value: "no_target",
      },
      {
        label: "QB Target",
        value: "qb_target",
      },
      {
        label: "OX-LIB Target",
        value: "ox_target",
      },
    ],
  },
  {
    type: "select",
    label: "Text UI Type",
    uniqueName: "textui_type",
    required: true,
    description: "Text UI Plugin",
    options: [
      {
        label: "",
        value: "",
      },
      {
        label: "No Text UI",
        value: "no_textui",
      },
      {
        label: "QB Text UI",
        value: "qb_textui",
      },
      {
        label: "OX-LIB Text UI",
        value: "ox_textui",
      },
      {
        label: "Draw Text Marker",
        value: "draw_text_marker",
      },
    ],
  },
  {
    type: "select",
    label: "Progress Bar Type",
    uniqueName: "progressbar_type",
    required: true,
    description: "The Plugin used for Progress Bar",
    options: [
      {
        label: "",
        value: "",
      },
      {
        label: "No Progress Bar",
        value: "no_progressbar",
      },
      {
        label: "QB Progress Bar",
        value: "qb_progressbar",
      },
      {
        label: "OX-LIB Progress Bar",
        value: "ox_progressbar",
      },
      {
        label: "Custom Progress Bar (Must be set in Config)",
        value: "custom_progressbar",
      },
    ],
  },
  {
    type: "select",
    label: "Skill Bar Type",
    uniqueName: "skillbar_type",
    required: true,
    description: "The Plugin used for Skill Bar",
    options: [
      {
        label: "",
        value: "",
      },
      {
        label: "No Skill Bar",
        value: "no_skillbar",
      },
      {
        label: "QB Skill Bar",
        value: "qb_skillbar",
      },
      {
        label: "OX-LIB Skill Bar",
        value: "ox_skillbar",
      },
      {
        label: "Custom Skill Bar (Must be set in Config)",
        value: "custom_skillbar",
      },
    ],
  },
  {
    type: "select",
    label: "Menu Type",
    uniqueName: "menu_type",
    required: true,
    description: "The Plugin used for Menu",
    options: [
      {
        label: "",
        value: "",
      },
      {
        label: "No Menu",
        value: "no_menu",
      },
      {
        label: "QB Menu",
        value: "qb_menu",
      },
      {
        label: "OX-LIB Menu",
        value: "ox_menu",
      },
    ],
  },
];
