package controllers
import (
    // "github.com/astaxie/beego"
    "io/ioutil"
    "path/filepath"
    "strings"
)

type File struct { Controller }

func (c *File) Get() {
    filename := c.Ctx.Input.Param(":splat")
    path := filepath.Join(RepositoryDir, filename)

    if strings.HasSuffix(path, ".json") {
        c.ServeJsonFile(path)
    } else {
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
}
