Factory.define('stop')
  .sequence('id')
  .attr('selected', false)

Factory.define('stoplist')
  .attr 'stops', -> [
    Factory.attributes('stop')
    Factory.attributes('stop')
    Factory.attributes('stop')
    Factory.attributes('stop')
    Factory.attributes('stop')
    Factory.attributes('stop')
    Factory.attributes('stop')
  ]
