require 'securerandom'
require 'benchmark'

STATUS = ['public', 'private', 'archived'].freeze
STATUS_SIZE = STATUS.size

result = Benchmark.realtime do
    100.times do |n|
        article =  Article.create!(
            title: "test#{n + 1}",
            body: SecureRandom.hex(1000),
            status: STATUS[n % STATUS_SIZE]
        )
        Comment.insert_all!(
            100000.times.map do |m| 
                {
                    commenter: "#{m + 1}roh",
                    body: SecureRandom.hex(100),
                    status: STATUS[m % STATUS_SIZE],
                    article_id: article.id
                }
            end
        )
    end    
end
puts "results: #{result}s"
