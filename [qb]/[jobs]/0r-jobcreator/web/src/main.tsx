import ReactDOM from "react-dom/client";
import App from "./components/App";
import { VisibilityProvider } from "./providers/VisibilityProvider";
import "./index.css";
import { RouterProvider } from "./providers/RouterProvider";
import { DataProvider } from "./providers/DataProvider";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <>
    <VisibilityProvider>
      <RouterProvider>
        <DataProvider>
          <App />
        </DataProvider>
      </RouterProvider>
    </VisibilityProvider>
  </>
);
