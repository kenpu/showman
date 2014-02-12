package controllers

import (
    "github.com/astaxie/beego"
    "path/filepath"
    "io/ioutil"
    "html/template"
    "encoding/json"
)

type Content struct {
    beego.Controller
}

func (c *Content) Get() {
    var contentPath = c.Ctx.Input.Param(":splat")
    var fscontentPath = filepath.Join(RepositoryDir, contentPath)
    content, err := ioutil.ReadFile(fscontentPath)
    if err != nil {
        c.Data["ContentPath"] = c
        c.TplNames = "notfound.tpl"
    } else {
        c.Data["Content"] = template.HTML(string(content))
        contentJS, _ := json.Marshal(string(content))
        c.Data["ContentJS"] = template.JS(string(contentJS))
        c.TplNames = "content.tpl"
    }
    c.Render()
}
