module Jekyll
  class Cats_Cat_Index < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'products_product_index.html')
      self.data['category'] = category
    end
  end
  class Cats_Cat_Generator < Generator
    safe true
    def generate(site)
      if site.layouts.key? 'products_product_index'
        dir = site.config['products_dir'] || 'products'
        site.categories.keys.each do |category|
          category = category.split(' ').map(&:capitalize).join(' ')
          cat_dirname = category.downcase.strip.gsub(/ /, '-')
          write_cat_index(site, File.join(dir, cat_dirname), category)
        end
      end
    end
    def write_cat_index(site, dir, category)
      index = Cats_Cat_Index.new(site, site.source, dir, category)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end
end