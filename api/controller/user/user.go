package user

import (
	"chaitham/jwt-api/orm"
	"net/http"

	"github.com/gin-gonic/gin"
)

func ReadAll(c *gin.Context) {
	var users []orm.User
	orm.Db.Find(&users)
	c.JSON(http.StatusOK, gin.H{"status": "ok", "message": "User Read Success", "users": users})
}

func Profile(c *gin.Context) {
	id := c.Param("id")
	var user orm.User
	orm.Db.First(&user, id)
	c.JSON(http.StatusOK, gin.H{"status": "ok", "message": "User Read Success", "user": user})
}

func Update(c *gin.Context) {
	id := c.Param("id")

	var body struct {
		Username string
		Password string
		Nickname string
	}

	if err := c.Bind(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	var user orm.User

	if err := orm.Db.First(&user, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
		return
	}

	if err := orm.Db.Model(&user).Updates(orm.User{
		Username: body.Username,
		Password: body.Password,
		Nickname: body.Nickname,
	}).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"status": "ok", "message": "User updated successfully", "user": user})
}

func Delete(c *gin.Context) {
	id := c.Param("id")
	if id == "1" {
		c.JSON(http.StatusForbidden, gin.H{"error": "Deletion of user ID 1 is not allowed"})
		return
	}
	orm.Db.Delete(&orm.User{}, id)
	c.JSON(http.StatusOK, gin.H{"status": "ok", "message": "Success"})

}
