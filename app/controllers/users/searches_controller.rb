class Users::SearchesController < ApplicationController
  def items
    @q = Item.ransack(ransack_item_params)
    @items = @q.result
    # DBにない場合にAPIを叩く&APIの情報を保存する
    if @items == []
      RakutenWebService::Books::CD.search(artist_name: ransack_item_params.values).each do |rakuten_item|
        # DBに同じアーティスト・レーベルがいた場合
        artist = Artist.find_by(name: rakuten_item.artist_name)
        label = Label.find_by(name: rakuten_item.label)
        unless artist.present?
          # DBに同じアーティストがいない場合、新しくレコードを作成・保存
          artist = Artist.create(name: rakuten_item.artist_name)
        end
        unless label.present?
          # DBに同じレーベルがいない場合、新しくレコードを作成・保存
          label = Label.create(name: rakuten_item.label)
        end
        #genreIDはまた別のAPIを叩きに行き、genreモデルに保存
        # ここでたまにid長いって怒られる
        RakutenWebService::Books::Genre.search(books_genre_id: rakuten_item.books_genre_id).each do |rakuten_genre|
          genre = Genre.create(name: rakuten_genre.parents[0]["books_genre_name"])
          # itemのDBに保存したい
          item = Item.new(
            artist_id: artist.id,
            label_id: label.id,
            genre_id: genre.id,
            title: rakuten_item.title,
            price: rakuten_item.item_price, #税込み販売価格
            jacket_image_id: rakuten_item.large_image_url,
            release: Date.strptime(rakuten_item.sales_date,'%Y年%m月%d日'), # 文字列からdate型に変換
            stock: 30
          )
          # itemが保存できたら、紐ついているdisc、songもcreate
          if item.save
            disc = Disc.create(item_id: item.id)
            # item内の曲をeach ###で区切られている為split
            rakuten_item.play_list.split("###").each do |song|
              Song.create(disc_id: disc.id, title: song)
            end
            # もしitemがうまくsaveできなかったら何かしら対策
          end
        end
      end
      # APIを使用した後のリダイレクト先
      @q = Item.ransack(ransack_item_params)
      @items = @q.result
      render "users/items/index"
    else
      # DBに商品があった場合のリダイレクト先
      render "users/items/index"
    end
  end

  private

  def ransack_item_params
    params.require(:q).permit(:title_or_artist_name_cont)
  end
end
