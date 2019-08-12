import React from 'react'
import ReactDOM from 'react-dom'
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import Setting from './containers/Setting'
import Manage from './containers/Manage'
import 'antd/dist/antd.css';

const App = () => (
  <Switch>
    <Route path="/manage" component={Manage} />
    <Route path="/" component={Setting} />
  </Switch>
);

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <div>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </div>,
    document.body.appendChild(document.createElement('div')),
  )
})
