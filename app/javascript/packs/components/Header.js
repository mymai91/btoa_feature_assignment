import React from 'react';
import { Layout, Menu } from 'antd';

const { Header } = Layout;

const HeaderLayout = props => {
  return (
    <Header className="header">
      <div className="logo" />
      <Menu
        theme="dark"
        mode="horizontal"
        defaultSelectedKeys={['/setting']}
        style={{ lineHeight: '64px' }}
      >
        <Menu.Item key="/setting">
          <a href="/setting">Setting</a>
        </Menu.Item>
        <Menu.Item key="/manage">
          <a href="/manage">Manage</a>
        </Menu.Item>
      </Menu>
    </Header>
  );
};

export default HeaderLayout;
