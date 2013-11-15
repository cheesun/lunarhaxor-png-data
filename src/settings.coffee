module.exports = {
  baseDir: __dirname + '/../'
  mongooseUrl: process.env.MONGOHQ_URL || "mongodb://localhost/png"
  port: process.env.PORT || 1337
}
