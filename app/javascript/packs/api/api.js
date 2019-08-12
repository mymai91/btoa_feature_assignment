import axios from 'axios';

const BASE_URL = 'http://localhost:3000/api/v1';

const api = () => {
  const instance = axios.create({
    baseURL: BASE_URL,
    timeout: 20000,
    headers: {
      'Content-Type': 'application/json',
    },
  });

  // instance.interceptors.response.use(
  //   function(response) {
  //     return response;
  //   },
  //   function(error) {
  //     return Promise.reject(error);
  //   },
  // );

  return instance;
};

export default api;
