package controllers
import (
    "github.com/astaxie/beego"
    "io/ioutil"
    "path/filepath"
)

type File struct { beego.Controller }

func (c *File) Get() {
    filename := c.Ctx.Input.Param(":splat")
    path := filepath.Join(RepositoryDir, filename)

    content, err := ioutil.ReadFile(path)
    json := make(map[string]interface{})

    if err != nil {
        json["error"] = err.Error()
    } else {
        json["content"] = string(content)
    }
    c.Data["json"] = json
    c.ServeJson()
}
