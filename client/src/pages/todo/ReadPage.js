import React from "react";
import {
  useSearchParams,
  useNavigate,
  useParams,
  createSearchParams,
} from "react-router-dom";

function ReadPage(props) {
  const { tno } = useParams();

  const navigate = useNavigate();

  const [queryParams, setQueryParams] = useSearchParams();

  const page = queryParams.get("page") ? parseInt(queryParams.get("page")) : 1;
  const size = queryParams.get("size") ? parseInt(queryParams.get("size")) : 10;

  const queryStr = createSearchParams({ page: page, size: size }).toString();

  console.log(tno);

  const moveTodModify = (tno) => {
    navigate({ pathname: `/todo/modify/${tno}`, search: queryStr });
  };

  const moveToList = () => {
    navigate({ pathname: `/todo/List`, search: queryStr });
  };

  return (
    <div className=" text-3xl">
      Todo Read Page {tno}
      <div>
        <button onClick={() => moveTodModify(tno)}>Test Modify</button>
        <button onClick={moveToList}>Test List</button>
      </div>
    </div>
  );
}

export default ReadPage;
