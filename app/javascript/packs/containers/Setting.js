import React, { useEffect, useState } from 'react';
import { Layout, Select, Row, Col, Button, Table } from 'antd';
import { settingApi, getIncomeApi } from '../api/setting';
import HeaderLayout from '../components/Header';

const { Option } = Select;
const { Content } = Layout;

const Setting = props => {
  const [isLoading, setIsLoading] = useState(true);
  const [roles, setRoles] = useState([]);
  const [companies, setCompanies] = useState([]);
  const [incomes, setIncomes] = useState([]);
  const [currentRole, setCurrentRole] = useState(null);
  const [currentCompany, setCurrentCompany] = useState(null);
  useEffect(() => {
    getSettingInfo();
  }, []);

  const getSettingInfo = () => {
    settingApi()
      .then(({ data }) => {
        const { roles, companies } = data;
        setRoles(roles);
        setCompanies(companies);
        setIsLoading(false);
      })
      .catch(err => {
        setIsLoading(false);
        console.log('err', err);
      });
  };

  const columnNames = (incomes.length > 0 && Object.keys(incomes[0])) || [];

  const generateColumns =
    columnNames &&
    columnNames.map(item => ({
      title: item,
      dataIndex: item,
    }));

  const handleChange = (value, type) => {
    if (type === 'role') {
      setCurrentRole(value);
    }
    if (type === 'company') {
      setCurrentCompany(value);
    }
  };

  const roleOptionsTemplate = roles.map(({ id, name }) => (
    <Option value={id} key={id}>
      {name}
    </Option>
  ));

  const getIncome = () => {
    setIncomes([]);
    const opts = {
      role_id: currentRole,
      company_id: currentCompany,
    };
    getIncomeApi(opts)
      .then(({ data: { incomes } }) => {
        setIncomes(incomes);
      })
      .catch(err => {
        console.log('err', err);
      });
  };

  const companyOptionsTemplate = companies.map(({ id, name }) => (
    <Option value={id} key={id}>
      {name}
    </Option>
  ));
  return (
    <Layout>
      <HeaderLayout />

      <Layout>
        {isLoading ? (
          <h3>Loading</h3>
        ) : (
          <Content
            style={{
              background: '#fff',
              padding: 24,
              margin: 0,
              minHeight: 280,
            }}
          >
            <h2>Access result</h2>
            <Row>
              <Col span={20} offset={2}>
                <Row gutter={16} className="mv-5">
                  <Col span={10}>
                    <h3>IAM</h3>
                    <Select
                      style={{ width: '60%' }}
                      placeholder="Select a role"
                      onChange={val => handleChange(val, 'role')}
                    >
                      {roleOptionsTemplate}
                    </Select>
                  </Col>

                  <Col span={10}>
                    <h3>From</h3>
                    <Select
                      placeholder="Select a company"
                      style={{ width: '60%' }}
                      onChange={val => handleChange(val, 'company')}
                    >
                      {companyOptionsTemplate}
                    </Select>
                  </Col>
                  <Col span={4}>
                    <h3>Result</h3>
                    <Button type="primary" onClick={() => getIncome()}>
                      View
                    </Button>
                  </Col>
                </Row>

                <Row gutter={16} className="mv-5">
                  {incomes.length > 0 && (
                    <Table dataSource={incomes} columns={generateColumns} rowKey="id" />
                  )}
                </Row>
              </Col>
            </Row>
          </Content>
        )}
      </Layout>
    </Layout>
  );
};

export default Setting;
