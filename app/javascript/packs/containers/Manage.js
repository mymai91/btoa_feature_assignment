import React, { useEffect, useState } from 'react';
import { Select, Row, Col, Button, Table } from 'antd';
import { manageApi, setAccessScopeApi } from '../api/setting';

const { Option } = Select;

const Manage = props => {
  const [isLoading, setIsLoading] = useState(true);
  const [roles, setRoles] = useState([]);
  const [tableFields, setTableFields] = useState([]);
  const [listTable, setListTable] = useState([]);
  const [currentTable, setCurrentTable] = useState(null);
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
    console.log('value', value);
    if (type === 'table') {
      setCurrentTable(value);
      const fields = tableFields[value];
      setFieldOptions(fields);
    }
    if (type === 'role') {
      setCurrentRole(value);
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
    };

    setAccessScopeApi(option)
      .then(response => {
        console.log('data===', response);
        setIsLoading(false);
      })
      .catch(err => {
        setIsLoading(false);
        console.log('err', err);
      });

    // setAccessScopeApi(option)
    //   .then(data => {
    //     setIsLoading(false);
    //     console.log('data', data);
    //   })
    //   .catch(err => {
    //     setIsLoading(false);
    //     console.log('err', err);
    //   });
    // console.log('options', option);
  };

  return (
    <div>
      {isLoading ? (
        <h3>Loading</h3>
      ) : (
        <Row>
          <Col span={20} offset={2}>
            <Row gutter={16}>
              <h3>Access Scope Setting</h3>

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

            <h3>Limit access</h3>
            <Row gutter={16}>
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
      )}
    </div>
  );
};

export default Manage;
