package controllers

import (
    "github.com/astaxie/beego"
    "path/filepath"
    "os"
)

type Dir struct {
    beego.Controller
}

func (c *Dir) Get() {
    c.TplNames = "dir.tpl"
    c.Render()
}
func (c *Dir) Post() {
    var paths = make([]string, 0)
    var walker filepath.WalkFunc = func(path string, info os.FileInfo, err error) error {
        if err != nil {
            return err
        } else {
            if ! info.IsDir() {
                path, _ = filepath.Rel(RepositoryDir, path)
                paths = append(paths, path)
            }
        }
        return nil
    }
    err := filepath.Walk(RepositoryDir, walker)
    json := make(map[string]interface{})
    if err != nil {
        json["error"] = err.Error()
    } else {
        json["paths"] = paths
    }
    c.Data["json"] = json
    c.ServeJson()
}
