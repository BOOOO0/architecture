// ajax 통신을 하는 함수를 작성할 것이고 그 함수를 통해 컴포넌트를 생성해서 페이지에 추가할 것

// 이후 클라우드에 배포할 때가 되면 아래 API_SERVER_HOST 상수만 변경하면 된다.
import axios from "axios";

export const API_SERVER_HOST = "http://request.boooo0.shop";

const prefix = `${API_SERVER_HOST}/api/todo`;

export const getOne = async (tno) => {
  const res = await axios.get(`${prefix}/${tno}`);
  return res.data;
};

export const getList = async (pageParam) => {
  const { page, size } = pageParam;

  // {params : {...pageParam}도 가능하다.
  // 일단 이건 리스트를 불러올때 파라미터들을 유지하기 위해서 같이 불러온다.
  const res = await axios.get(`${prefix}/list`, { params: { page, size } });

  return res.data;
};

export const postAdd = async (todoObj) => {
  // 이제는 JSON.stringify 없이 axios를 쓰면 객체를 넘기면 그대로 JSON으로 넘어간다.
  const res = await axios.post(`${prefix}/`, todoObj);

  return res.data;
};

export const deleteOne = async (tno) => {
  const res = await axios.delete(`${prefix}/${tno}`);

  return res.data;
};

export const putOne = async (todo) => {
  const res = await axios.put(`${prefix}/${todo.tno}`, todo);

  return res.data;
};
