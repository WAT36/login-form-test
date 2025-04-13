"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

export default function MyPage() {
  const router = useRouter();
  const [loading, setLoading] = useState(true);
  const [, setToken] = useState<string | null>(null);

  useEffect(() => {
    const idToken = localStorage.getItem("idToken");

    if (!idToken) {
      router.replace("/login"); // 未ログインならログインページへ
    } else {
      setToken(idToken);
      setLoading(false);
    }
  }, []);

  if (loading) return <p>読み込み中...</p>;

  return (
    <div style={{ padding: "2rem" }}>
      <h1>マイページ</h1>
      <p>ようこそ、ログイン済みのユーザーさん！</p>
    </div>
  );
}
