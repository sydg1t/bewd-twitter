class TweetsController < ApplicationController
    def create
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        if session
            user = session.user

            tweet = user.tweets.build(tweet_params)

            if tweet.save
                render json: { tweet: {
                    username: user.username, 
                    message: tweet.message}
                }, status: :created
            else
                render json: { errors: tweet.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: { error: "Unauthorized" }, status: :unauthorized
        end
    end

    def destroy
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)
        
        
        if session
            user = session.user
            tweet = user.tweets.find_by(id: params[:id])

            if tweet 
                tweet.destroy 
                render json: {success: true}
            else
                render json: {success: false}
            end
        else
            render json: {success: false }
        end
    end

    def index
       @tweets = Tweet.all
       render 'feeds/index.jbuilder'
    end

    def index_by_user
        user = User.find_by(username: params[:username])

        if user
            @tweets = user.tweets.order(created_at: :desc)
            render :index_by_user, formats: :json
        else
            render json: { error: 'User not found' }, status: :not_found
        end
    end

    private

    def tweet_params
        params.require(:tweet).permit(:message)
    end
end
