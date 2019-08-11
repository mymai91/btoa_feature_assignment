import api from './api';

const settingApi = () => {
  return api().get('/setting/info');
};

export { settingApi };
