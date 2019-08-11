import React, { useEffect, useState } from 'react';
import { Select, Row, Col, Button } from 'antd';
import { settingApi } from '../api/setting';

const { Option } = Select;

const DashboardContainer = props => {
  const [isLoading, setIsLoading] = useState(true);
  const [roles, setRoles] = useState([]);
  const [companies, setCompanies] = useState([]);
  useEffect(() => {
    console.log('use effect');
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
  }, []);

  const handleChange = value => {
    console.log(`selected ${value}`);
  };

  const roleOptionsTemplate = roles.map(({ id, name }) => (
    <Option value={id} key={id}>
      {name}
    </Option>
  ));

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
                <Button type="primary">View</Button>
              </Col>
            </Row>
          </Col>
        </Row>
      )}
    </div>
  );
};

export default DashboardContainer;
