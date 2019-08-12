import api from './api';

const settingApi = () => {
  return api().get('/setting/info');
};

const getIncomeApi = options => {
  return api().get('/income/index', { params: options });
};

const manageApi = () => {
  return api().get('setting/manage_table');
};

const setAccessScopeApi = options => {
  return api().post('setting/access_scope', options);
};

export { settingApi, getIncomeApi, manageApi, setAccessScopeApi };
