package controllers
import (
    "github.com/astaxie/beego"
)

type Repo struct { beego.Controller }

func (c *Repo) Get() {
    c.TplNames = "repo.tpl"
    c.Render()
}

//
// Returns the JSON data on the directory tree
//
func (c *Repo) Post() {
    files, err := listFiles(RepositoryDir)
    
    json := make(map[string]interface{})
    if err == nil {
        json["files"] = files
    } else {
        json["error"] = err.Error()
    }
    c.Data["json"] = json
    c.ServeJson()
}
