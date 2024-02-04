import React from "react";
import AddComponent from "../../components/todo/AddComponent";

function AddPage(props) {
  return (
      <div className="p-4 w-full bg-white">
          <div className="text-3xl font-extrabold">
              Todo Add Page
          </div>
          <AddComponent/>
      </div>
  );
}

export default AddPage;
