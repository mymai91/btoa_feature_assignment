import React, { useEffect, useState } from 'react';
import { Select, Row, Col, Button, Table } from 'antd';
import { settingApi, getIncomeApi } from '../api/setting';

const { Option } = Select;

const Setting = props => {
  const [isLoading, setIsLoading] = useState(true);
  const [roles, setRoles] = useState([]);
  const [companies, setCompanies] = useState([]);
  const [incomes, setIncomes] = useState([]);
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

  const columns = [
    {
      title: 'Employee Name',
      dataIndex: 'employee_name',
    },
    {
      title: 'Base Salary',
      dataIndex: 'base_salary',
    },
  ];

  const handleChange = value => {
    console.log(`selected ${value}`);
  };

  const roleOptionsTemplate = roles.map(({ id, name }) => (
    <Option value={id} key={id}>
      {name}
    </Option>
  ));

  const getIncome = () => {
    const opts = {
      role_id: 3,
      company_id: 1,
    };
    getIncomeApi(opts)
      .then(({ data: { incomes } }) => {
        setIncomes(incomes);
        console.log('resetDayDetailFetchData===', incomes);
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
  // const roleOptionsTemplate = <div>Test</div>;
  return (
    <div>
      {isLoading ? (
        <h3>Loading</h3>
      ) : (
        <Row>
          <Col span={20} offset={2}>
            <Row gutter={16}>
              <Col span={10}>
                <h3>IAM</h3>
                <Select
                  style={{ width: '60%' }}
                  placeholder="Select a role"
                  onChange={handleChange}
                >
                  {roleOptionsTemplate}
                </Select>
              </Col>

              <Col span={10}>
                <h3>From</h3>
                <Select
                  placeholder="Select a company"
                  style={{ width: '60%' }}
                  onChange={handleChange}
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

            <Row gutter={16}>
              <Table dataSource={incomes} columns={columns} rowKey="id" />
            </Row>
          </Col>
        </Row>
      )}
    </div>
  );
};

export default Setting;
