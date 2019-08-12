import React, { useEffect, useState } from 'react';
import { Layout, Select, Row, Col, Button, notification } from 'antd';
import { manageApi, setAccessScopeApi } from '../api/setting';
import HeaderLayout from '../components/Header';

const { Option } = Select;
const { Content } = Layout;

const Manage = props => {
  const [isLoading, setIsLoading] = useState(true);
  const [roles, setRoles] = useState([]);
  const [tableFields, setTableFields] = useState([]);
  const [listTable, setListTable] = useState([]);
  const [currentTable, setCurrentTable] = useState(null);
  const [currentIam, setCurrentIam] = useState(null);
  const [currentRole, setCurrentRole] = useState(null);
  const [currentScope, setCurrentScope] = useState(null);
  const [fieldOptions, setFieldOptions] = useState([]);
  useEffect(() => {
    getManageInfo();
  }, []);

  const getManageInfo = () => {
    manageApi()
      .then(({ data }) => {
        const { roles, table_fields, list_table } = data;
        setRoles(roles);
        setTableFields(table_fields);
        setListTable(list_table);
        setIsLoading(false);
      })
      .catch(err => {
        setIsLoading(false);
        console.log('err', err);
      });
  };

  const handleChange = (value, type) => {
    if (type === 'table') {
      setCurrentTable(value);
      const fields = tableFields[value];
      setFieldOptions(fields);
    }
    if (type === 'role') {
      setCurrentRole(value);
    }
    if (type === 'iam') {
      setCurrentIam(value);
    }
    if (type === 'scope') {
      setCurrentScope(value);
    }
  };

  const roleOptionsTemplate = roles.map(({ id, name }) => (
    <Option value={id} key={id}>
      {name}
    </Option>
  ));

  const listTableOptionsTemplate = listTable.map((table, i) => (
    <Option value={table} key={i}>
      {table}
    </Option>
  ));

  const accessFieldOptionsTemplate = fieldOptions.map((name, i) => (
    <Option value={name} key={i}>
      {name}
    </Option>
  ));

  const submitAccessScope = () => {
    setIsLoading(true);

    const option = {
      role_id: currentRole,
      table_name: currentTable,
      field_access: currentScope,
      iam_id: currentIam,
    };

    setAccessScopeApi(option)
      .then(({ data: { message } }) => {
        openNotification('success', message);
        setIsLoading(false);
      })
      .catch(err => {
        const message = err.response.status === 403 ? 'No permission' : 'Something Error';
        openNotification('error', message);
        setIsLoading(false);
      });
  };

  const openNotification = (type, message) => {
    notification[type]({
      message: 'Manage Setting Error',
      description: message,
    });
  };

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
            <h2>Manage Access Scope Setting</h2>
            <Row>
              <Col span={20} offset={2}>
                <Row gutter={16} className="mv-5">
                  <Col span={10}>
                    <h3>IAM</h3>
                    <Select
                      style={{ width: '60%' }}
                      placeholder="Select a role"
                      onChange={val => handleChange(val, 'iam')}
                    >
                      {roleOptionsTemplate}
                    </Select>
                  </Col>
                </Row>

                <Row gutter={16} className="mv-5">
                  <Col span={10}>
                    <h3>Setting For Role</h3>
                    <Select
                      style={{ width: '60%' }}
                      placeholder="Select a role"
                      onChange={val => handleChange(val, 'role')}
                    >
                      {roleOptionsTemplate}
                    </Select>
                  </Col>

                  <Col span={10}>
                    <h3>Manage on</h3>
                    <Select
                      style={{ width: '60%' }}
                      placeholder="Select a table"
                      onChange={val => handleChange(val, 'table')}
                    >
                      {listTableOptionsTemplate}
                    </Select>
                  </Col>
                </Row>

                <h3 className="mv-5">Limit access</h3>
                <Row gutter={16} className="mv-5">
                  <Col span={24}>
                    <h3>Manage on</h3>
                    <Select
                      mode="multiple"
                      style={{ width: '100%' }}
                      placeholder="Please select"
                      onChange={val => handleChange(val, 'scope')}
                    >
                      {accessFieldOptionsTemplate}
                    </Select>
                  </Col>
                </Row>
                <Button type="primary" onClick={() => submitAccessScope()}>
                  Submit
                </Button>
              </Col>
            </Row>
          </Content>
        )}
      </Layout>
    </Layout>
  );
};

export default Manage;
