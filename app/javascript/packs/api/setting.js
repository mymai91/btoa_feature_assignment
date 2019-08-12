import api from './api';

const settingApi = () => {
  return api().get('/setting/info');
};

const getIncomeApi = options => {
  return api().get('/income/index', { params: options });
};

export { settingApi, getIncomeApi };
